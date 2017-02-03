TraitType = GraphQL::ObjectType.define do
  name 'Trait'
  description 'Properties posessed by a specific space'

  interfaces [GraphQL::Relay::Node.interface]
  global_id_field :id

  field :space,    SpaceType
  field :property, PropertyType
  field :value, ValueEnum do
    resolve ->(obj, args, ctx) {
      obj.value.name
    }
  end
  field :description, types.String
end
