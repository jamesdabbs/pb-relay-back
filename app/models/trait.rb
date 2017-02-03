class Trait < ApplicationRecord
  belongs_to :space
  belongs_to :property
  belongs_to :value

  default_scope -> { order property_id: :asc, space_id: :asc }
end
