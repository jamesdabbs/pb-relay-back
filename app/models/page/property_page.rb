module Page
  class PropertyPage
    def self.from_revision
      new Property.new \
        name:        rev.get("name"),
        description: rev.get("description")
    end

    def initialize property
      @property = property
    end

    def path
      "properties/#{H.slug title}.md"
    end

    def title
      @property.name
    end

    def contents
      Writer.write do |w|
        w.frontmatter \
          uid:  @property.uid,
          name: @property.name
        w.section '', @property.description
      end
    end

    def self.parse path, contents
      Scanner.scan contents do |s|
        keys               = s.frontmatter :uid, :name
        keys[:description] = s.section

        Property.new keys
      end
    end
  end
end
