module Page
  class TraitPage
    include ApplicationPage

    def self.from_revision
      new Trait.new \
          id:          rev.get("id"),
          description: rev.get("description")
    end

    def initialize trait
      @object = @trait = trait
    end

    def path
      "spaces/#{@trait.space.name}/properties/#{@trait.property.name}.md"
    end

    def title
      "#{@trait.space.name}: #{@trait.property.name}"
    end

    def contents
      render :trait
    end
  end
end
