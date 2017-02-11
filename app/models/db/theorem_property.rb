class DB::TheoremProperty < ApplicationRecord
  belongs_to :theorem
  belongs_to :property
end
