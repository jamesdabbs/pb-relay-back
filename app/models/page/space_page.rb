module Page
  class SpacePage
    def self.from_revision rev
      new Space.new \
        name:              rev.get("name"),
        description:       rev.get("description"),
        proof_of_topology: rev.get("proof_of_topology"),
        updated_at:        rev.get("created_at")
    end

    def initialize space
      @space = space
    end

    def path
      "spaces/#{H.slug title}/README.md"
    end

    def title
      @space.name
    end

    def contents
      Writer.write do |w|
        w.frontmatter \
          uid:  @space.uid,
          name: @space.name
        w.section '', @space.description
        w.section 'Proof of Topology', @space.proof_of_topology
      end
    end

    def self.parse path, contents
      Scanner.scan contents do |s|
        keys                     = s.frontmatter :uid, :name
        keys[:description]       = s.section
        keys[:proof_of_topology] = s.section 'Proof of Topology'

        Space.new keys
      end
    end
  end
end
