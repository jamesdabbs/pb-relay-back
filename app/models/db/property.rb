class DB::Property < ApplicationRecord
  belongs_to :value_set

  has_many :traits

  def self.lookup id
    find_by(id: id) || find_by(name: id)
  end

  def uid
    id
  end

  def slug
    name.downcase.gsub(/\W+/, '-')
  end
end
