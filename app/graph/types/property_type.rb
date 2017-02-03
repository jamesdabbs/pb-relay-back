PropertyType = GraphQL::ObjectType.define do
  name "Property"
  description "A property that a space might have - compact, connected, &c."

  interfaces [GraphQL::Relay::Node.interface]
  global_id_field :id

  field :name,        types.String
  field :slug,        types.String
  field :description, types.String

  connection :traits, TraitType.connection_type
end
