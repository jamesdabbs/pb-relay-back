SpaceType = GraphQL::ObjectType.define do
  name 'Space'
  description 'A topological space'

  interfaces [GraphQL::Relay::Node.interface]
  global_id_field :id

  field :name,        types.String
  field :slug,        types.String
  field :description, types.String

  connection :traits, TraitType.connection_type do
    argument :propertyId, types.String
  end
end
