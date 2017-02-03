class Theorem < ApplicationRecord
  has_many :theorem_properties
  has_many :properties, through: :theorem_property
end
