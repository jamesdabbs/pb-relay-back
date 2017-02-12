module Git
  def self.go; Writer.new.run; end

  Change = Struct.new :pages, :author, :message do
    def timestamp
      author.fetch :time
    end
  end

  class Writer
    attr_reader :repo, :logger

    def initialize path: nil, delete: false
      path = path ? path.to_s : Rails.root.join('tmp', 'repo').to_s
      if delete
        raise "I'm not deleting #{path}" unless path.start_with?(Rails.root.to_s)
        FileUtils.rm_rf path
        @repo = Rugged::Repository.init_at path
      else
        @repo = Rugged::Repository.new path
      end

      @logger   = Rails.logger
      @universe = Universe.new DB::Queries.new
      @initials, @changes = [], []
    end

    def run
      q = @universe.queries
      write_items q.all_theorems,   revs_for(DB::Theorem)
      write_items q.all_traits,     revs_for(DB::Trait)
      write_items q.all_spaces,     revs_for(DB::Space)
      write_items q.all_properties, revs_for(DB::Property)
      commit_all
    end

    def commit_all
      logger.info "Commiting #{@changes.count + 1} changes"

      # FIXME
      author = {
        email: "jamesdabbs@gmail.com",
        name:  "James Dabbs",
        time:  5.years.ago.to_time
      }
      commit_change Change.new(@initials, author, "Initial commit")
      @initials.clear

      @changes.
        sort_by(&:timestamp).
        each { |c| commit_change c }.
        clear
    end

    def commit_change change
      index = repo.index

      change.pages.each do |page|
        oid = repo.write page.contents, :blob
        index.add path: page.path, oid: oid, mode: 0100644
      end

      tree = index.write_tree repo
      Rugged::Commit.create repo,
        tree:       tree,
        author:     change.author,
        message:    change.message,
        parents:    repo.empty? ? [] : [repo.head.target].compact,
        update_ref: 'HEAD'
    end

    def revs_for klass
      DB::Revision.
        where(item_class: klass.name).
        includes(:user).
        map { |r| [r.item_id, r] }.
        to_h
    end

    def write_class klass, *includes
      logger.info "Batching changes for #{klass.name}"
      items     = includes.any? ? klass.all.includes(*includes) : klass.all
      revisions = revs_for klass

      write_items items, revisions
    end

    def write_items items, revisions
      revs, unrevs = items.partition { |i| revisions.include? i._id }

      # Write unrevised objects
      unrevs.each do |obj|
        page = Page.for_object obj
        @initials.push page
      end

      # Write space revisions
      revs.each do |obj|
        rev  = revisions.fetch obj.id
        page = Page.for_revision rev, obj

        name   = rev.user.name || rev.user.ident
        author = { email: rev.user.ident, name: name, time: rev.created_at.to_time }
        @changes.push Change.new([page], author, "Updated '#{page.title}'")
      end
    end
  end
end
