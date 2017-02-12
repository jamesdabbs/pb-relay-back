module Page
  class TheoremPage
    include ApplicationPage

    def self.from_revision
      # description, antecedent, consequent, converseIds
      new Theorem.new id: rev.item_id, description: rev.get("description")
    end

    def initialize theorem
      @theorem = theorem
    end

    def path
      "theorems/#{title}.md"
    end

    def title
      @theorem.uid
    end

    def contents
      Writer.write do |w|
        w.frontmatter \
          uid:        @theorem.uid,
          antecedent: @theorem.antecedent.map { |p| p.slug }.to_yaml,
          consequent: @theorem.consequent.map { |p| p.slug }.to_yaml
        w.section '', @theorem.description
      end
    end

    def self.parse path, contents
      Scanner.scan contents do |s|
        keys = s.frontmatter :uid, :antecedent, :consequent
        keys[:antecedent]  = Formula.from_json keys[:antecedent]
        keys[:consequent]  = Formula.from_json keys[:consequent]
        keys[:description] = s.section

        Theorem.new keys
      end
    end
  end
end
