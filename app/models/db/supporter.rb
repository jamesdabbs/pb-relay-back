class DB::Supporter < ApplicationRecord
  belongs_to :assumed
  belongs_to :implied
end
