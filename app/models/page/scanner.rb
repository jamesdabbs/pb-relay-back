module Page
  class Scanner
    def self.scan page
      yield new(page)
    end

    def initialize page
      _, head, body = page.split('---', 3)
      @front = YAML.load head

      @sections, current = { '' => '' }, ''
      body.each_line do |l|
        if l =~ /\[\[([^\]])\]\]/ # [[section title]]
          current = $1
        end
        @sections[current] += l
      end
    end

    def frontmatter *keys
      keys.each_with_object({}) do |key, hash|
        hash[key] = @front[key.to_s]
      end
    end

    def section name=nil
      s = name ? @sections[name] : @sections.first.last
      s && s.strip
    end
  end
end
