class DB::Theorem < ApplicationRecord
  has_many :theorem_properties
  has_many :properties, through: :theorem_property

  serialize :antecedent, JSON
  serialize :consequent, JSON

  def uid
    id
  end

  def name
    {
      antecedent: Formula.parse(antecedent),
      consequent: Formula.parse(consequent)
    }
  end

  def preview
    description.split("\n").first
  end

  def to_value formula:
    ::Theorem.new \
      uid:         id,
      antecedent:  formula.(antecedent),
      consequent:  formula.(consequent),
      description: description
  end
end
