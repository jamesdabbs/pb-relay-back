module Page
  class TraitPage
    def self.from_revision
      new Trait.new \
        id:          rev.get("id"),
        description: rev.get("description")
    end

    def initialize trait
      @trait = trait
    end

    def path
      "spaces/#{@trait.space.slug}/properties/#{@trait.property.slug}.md"
    end

    def title
      "#{@trait.space.name}: #{@trait.property.name}"
    end

    def contents
      Writer.write do |w|
        w.frontmatter \
          uid:      @trait.uid,
          space:    @trait.space.slug,
          property: @trait.property.slug,
          value:    @trait.value
        w.section '', @trait.description
      end
    end

    def self.parse path, contents, spaces:, properties:
      Scanner.scan contents do |s|
        keys = s.frontmatter :uid, :space, :property, :value
        keys[:space]       = spaces.(keys[:space])
        keys[:property]    = properties.(keys[:property])
        keys[:description] = s.section
        keys[:deduced]     = false # FIXME

        Trait.new keys
      end
    end
  end
end
