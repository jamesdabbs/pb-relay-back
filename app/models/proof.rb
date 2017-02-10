class Proof < ApplicationRecord
  belongs_to :trait
  belongs_to :theorem

  has_many :assumptions
  has_many :traits, through: :assumptions

  def self.serialize theorems, traits
    {
      theorems: theorems.map do |t|
        {
          uid:  t.id,
          name: JSON.parse(t.name)
        }
      end,
      traits: traits.includes(:property).map do |t|
        {
          uid:   t.id,
          property: {
            name: t.property.name,
            uid:  t.property.id
          },
          value: t.value_id == Formula::TrueId
        }
      end
    }.to_json
  end

  def to_json
    Proof.serialize([theorem], traits)
  end
end
