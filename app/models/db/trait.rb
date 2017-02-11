class DB::Trait < ApplicationRecord
  belongs_to :space
  belongs_to :property
  belongs_to :value

  has_one :proof
end
