class Property < ApplicationRecord
  belongs_to :value_set

  has_many :traits

  def slug
    name.downcase.gsub(/\W+/, '-')
  end
end
