UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'A site user'

  connection :spaces,     SpaceType.connection_type
  connection :properties, PropertyType.connection_type
  connection :traits,     TraitType.connection_type
end
