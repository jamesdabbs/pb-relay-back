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

    def find_space slug
      space  = subtree repo.head.target.tree, 'spaces', slug
      readme = repo.lookup space["README.md"][:oid]
      Page::SpacePage.parse nil, readme.content
    end

    def all_properties
      props = subtree repo.head.target.tree, 'properties'
      props.enum_for(:each_blob).map do |p|
        page = repo.lookup p[:oid]
        Page::PropertyPage.parse p[:name], page.content
      end
    end

    def find_property slug
      props = subtree repo.head.target.tree, 'properties'
      page  = repo.lookup props["#{slug}.md"][:oid]
      Page::PropertyPage.parse nil, page.content
    end

    def all_theorems
      theorems = subtree repo.head.target.tree, 'theorems'
      theorems.enum_for(:each_blob).map do |t|
        page = repo.lookup t[:oid]
        Page::TheoremPage.parse t[:name], page.content, properties: properties
      end
    end

    def space_traits space, property_name: nil
      traits = subtree repo.head.target.tree, 'spaces', space.slug, 'properties'
      traits.enum_for(:each_blob).map do |t|
        next if property_name && t[:name] != "#{H.slug(property_name)}.md"
        page = repo.lookup t[:oid]
        Page::TraitPage.parse t[:name], page.content,
          properties: properties, spaces: spaces
      end.compact
    end

    def theorems_by_ids ids
      warn "Theorem scan"
      all_theorems.select { |t| ids.include? t.uid }
    end

    private

    def subtree tree, *at
      curr = tree
      while path = at.shift
        curr = repo.lookup curr[path][:oid]
      end
      curr
    end

    class Cache
      def initialize method
        @method, @store = method, {}
      end

      def call *args
        @store[ args ] ||= @method.call(*args)
      end
    end

    def properties
      @_properties ||= Cache.new(method :find_property)
    end

    def spaces
      @_spaces ||= Cache.new(method :find_space)
    end
  end
end
