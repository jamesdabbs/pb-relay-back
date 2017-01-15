SpaceType = GraphQL::ObjectType.define do
  name 'Space'
  description 'A topological space'

  interfaces [GraphQL::Relay::Node.interface]

  field :id,          types.String
  field :name,        types.String
  field :slug,        types.String
  field :description, types.String

  connection :traits, TraitType.connection_type
end
