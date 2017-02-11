module Page
  class SpacePage
    include ApplicationPage

    def self.from_revision rev
      new Space.new \
        name:              rev.get("name"),
        description:       rev.get("description"),
        proof_of_topology: rev.get("proof_of_topology"),
        updated_at:        rev.get("created_at")
    end

    def initialize space
      @object = @space = space
    end

    def path
      "spaces/#{title}/README.md"
    end

    def title
      @space.name
    end

    def contents
      render :space
    end
  end
end
