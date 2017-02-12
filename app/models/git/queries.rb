module Git
  class Queries
    attr_reader :repo_path

    def initialize path
      @repo_path = path
    end

    def repo
      @repo ||= Rugged::Repository.new(repo_path.to_s)
    end

    def all_spaces
      spaces = subtree repo.head.target.tree, 'spaces'
      spaces.enum_for(:each_tree).map do |s|
        space = repo.lookup s[:oid]
        Page::SpacePage.parse s[:name],
          repo.lookup(space['README.md'][:oid]).content
      end
    end

    def all_properties
      props = subtree repo.head.target.tree, 'properties'
      props.enum_for(:each_blob).map do |p|
        page = repo.lookup p[:oid]
        Page::PropertyPage.parse p[:name], page.content
      end
    end

    def all_theorems
      theorems = subtree repo.head.target.tree, 'theorems'
      theorems.enum_for(:each_blob).map do |t|
        page = repo.lookup t[:oid]
        Page::TheoremPage.parse t[:name], page.content
      end
    end

    def space_traits space
      traits = subtree repo.head.target.tree, 'spaces', space.slug, 'properties'
      traits.enum_for(:each_blob).map do |t|
        page = repo.lookup t[:oid]
        Page::TraitPage.parse t[:name], page.content
      end
    end

    private

    def subtree tree, *at
      curr = tree
      while path = at.shift
        curr = repo.lookup curr[path][:oid]
      end
      curr
    end
  end
end
