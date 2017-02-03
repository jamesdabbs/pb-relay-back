class Space < ApplicationRecord
  has_many :traits

  def self.lookup id
    find_by(id: id) || find_by(name: id)
  end

  def uid
    id
  end

  def slug
    name
  end
end
