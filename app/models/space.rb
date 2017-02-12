class Space < Dry::Struct
  attribute :uid,         T::String
  attribute :name,        T::String

  # TODO: should SpaceWithDescription be a different type?
  attribute :description,       T::String.optional
  attribute :proof_of_topology, T::String.optional

  def _id;  uid; end
  def slug; H.slug name; end
end
