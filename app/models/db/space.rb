class DB::Space < ApplicationRecord
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

  def preview
    description.split("\n").first
  end

  def to_value
    ::Space.new \
      uid:               id,
      name:              name,
      description:       description,
      proof_of_topology: proof_of_topology
  end
end
