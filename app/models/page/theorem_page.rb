module Page
  class TheoremPage
    include ApplicationPage

    def self.from_revision
      # description, antecedent, consequent, converseIds
      new Theorem.new id: rev.item_id, description: rev.get("description")
    end

    def initialize theorem
      @object = @theorem = theorem
    end

    def path
      "theorems/#{title}.md"
    end

    def title
      @theorem.id
    end

    def contents
      render :theorem
    end
  end
end
