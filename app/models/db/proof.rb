class DB::Proof < ApplicationRecord
  belongs_to :trait
  belongs_to :theorem

  has_many :assumptions
  has_many :traits, through: :assumptions
end
