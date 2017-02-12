module Page
  class Writer
    def self.write
      w = new
      yield w
      w.result
    end

    def initialize
      @buffer = StringIO.new
    end

    def frontmatter keys
      out YAML.dump keys.map { |k,v| [k.to_s, v] }.to_h
      out '---'
    end

    def section title, body, when_empty: false
      # Idea: enforce only one empty section?
      return unless body.present? || when_empty

      out "[[#{title}]]" if title.present?
      out body
      out ''
    end

    def result
      @buffer.string
    end

    private

    def out str
      @buffer.puts str
    end
  end
end
