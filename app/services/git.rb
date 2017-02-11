class Git
  Change = Struct.new :pages, :author, :message do
    def timestamp
      author.fetch :time
    end
  end

  attr_reader :repo, :logger

  def initialize
    path = Rails.root.join('tmp', 'repo').to_s
    FileUtils.rm_rf path

    @logger = Rails.logger
    @repo   = Rugged::Repository.init_at path
    @initials, @changes = [], []
  end

  def self.go; new.run; end

  def run
    write_class Trait, :space, :property, :value
    write_class Space
    write_class Property
    write_class Theorem

    logger.info "Commiting #{@changes.count} changes"

    # FIXME
    author = {
      email: "jamesdabbs@gmail.com",
      name:  "James Dabbs",
      time:  5.years.ago.to_time
    }
    commit_change Change.new(@initials, author, "Initial commit")

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

  def write_class klass, *includes
    logger.info "Batching changes for #{klass.name}"
    items     = includes.any? ? klass.all.includes(*includes) : klass.all
    revisions = Revision.
                  where(item_class: klass.name).
                  includes(:user).
                  map do |rev|
      [rev.item_id, rev]
    end.to_h

    revs, unrevs = items.partition { |i| revisions.include? i.id }

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
