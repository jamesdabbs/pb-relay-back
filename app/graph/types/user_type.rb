UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'A site user'

  connection :spaces,     SpaceType.connection_type
  connection :properties, PropertyType.connection_type
  connection :traits,     TraitType.connection_type

  # field :trait, TraitType do
  #   argument :spaceId, !types.String
  #   argument :propertyId, !types.String
  #   resolve ->(space, args, ctx) {
  #     space.traits.find_by property_id: args[:propertyId]
  #   }
  # end
end
