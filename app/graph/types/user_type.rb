UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'A site user'

  field :spaces,     types[SpaceType]
  field :properties, types[PropertyType]
  field :traitTable, types.String do
    argument :spaceId,    types.String
    argument :propertyId, types.String

    resolve ->(user, args, ctx) {
      TraitTable.new(
        space_id: args[:spaceId], property_id: args[:propertyId]
      ).to_json
    }
  end

  # field :trait, TraitType do
  #   argument :spaceId, !types.String
  #   argument :propertyId, !types.String
  #   resolve ->(space, args, ctx) {
  #     space.traits.find_by property_id: args[:propertyId]
  #   }
  # end
end
