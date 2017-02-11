class Trait < Dry::Struct
  attribute :space,       ::Space
  attribute :property,    ::Property
  attribute :description, T::String
  attribute :value,       T::Bool
end
