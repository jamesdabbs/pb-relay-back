class Trait < Dry::Struct
  attribute :uid,         T::String
  attribute :space,       ::Space
  attribute :property,    ::Property
  attribute :value,       T::Bool
  attribute :description, T::String
  attribute :deduced,     T::Bool

  def _id;  uid; end
  def slug; H.slug name; end
end
