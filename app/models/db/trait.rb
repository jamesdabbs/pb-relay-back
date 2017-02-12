class DB::Trait < ApplicationRecord
  belongs_to :space
  belongs_to :property
  belongs_to :value

  has_one :proof

  def to_value properties:, spaces:
    ::Trait.new \
      uid:         id,
      space:       spaces.fetch(space_id),
      property:    properties.fetch(property_id),
      value:       value_id == Universe.true_id,
      description: description,
      deduced:     deduced
  end
end
