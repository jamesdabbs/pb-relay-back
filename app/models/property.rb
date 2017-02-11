class Property < Dry::Struct
  attribute :uid,         T::String
  attribute :name,        T::String
  attribute :description, T::String.optional

  def self.from_db p
    new uid: p.id, name: p.name, description: p.description
  end
end
