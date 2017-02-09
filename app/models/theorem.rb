class Theorem < ApplicationRecord
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
    }.to_json
  end

  def preview
    description.split("\n").first
  end
end
