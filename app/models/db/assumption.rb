class DB::Assumption < ApplicationRecord
  belongs_to :proof
  belongs_to :trait
end
