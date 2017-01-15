TraitType = GraphQL::ObjectType.define do
  name 'Trait'
  description 'Properties posessed by a specific space'

  field :id,       types.String
  field :value,    ValueEnum
  field :space,    SpaceType
  field :property, PropertyType
end
