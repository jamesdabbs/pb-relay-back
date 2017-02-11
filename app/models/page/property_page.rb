module Page
  class PropertyPage
    include ApplicationPage

    def self.from_revision
      new Property.new \
          name:        rev.get("name"),
          description: rev.get("description")
    end

    def initialize property
      @object = @property = property
    end

    def path
      "properties/#{title}.md"
    end

    def title
      @property.name
    end

    def contents
      render :property
    end
  end
end
