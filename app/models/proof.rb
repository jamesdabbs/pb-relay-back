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
          name: t.name
        }
      end,
      traits: traits.includes(:property).map do |t|
        {
          uid: t.id,
          property: {
            uid:  t.property.id,
            name: t.property.name
          },
          value: t.value_id == Universe::TrueId
        }
      end
    }
  end

  def to_json
    Proof.serialize([theorem], traits).to_json
  end
end
