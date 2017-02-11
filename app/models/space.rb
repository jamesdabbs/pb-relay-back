class Space < Dry::Struct
  attribute :uid,         T::String
  attribute :name,        T::String
  attribute :description, T::String.optional # TODO: should this be a different type?

  def self.from_db s
    new uid: s.id, name: s.name, description: s.description
  end
end
