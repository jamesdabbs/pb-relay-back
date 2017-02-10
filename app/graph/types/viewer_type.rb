byNameOrId = ->(attr) {
  ->(user, args, ctx) {
    scope = user.send(attr)
    if args[:uid]
      scope.where(id: args[:uid])
    elsif args[:name]
      scope.where(name: args[:name])
    else
      scope
    end
  }
}
ViewerType = GraphQL::ObjectType.define do
  name 'Viewer'
  description 'A site user'

  field :spaces, types[SpaceType] do
    argument :uid,  types.String
    argument :name, types.String

    resolve byNameOrId.(:spaces)
  end

  field :properties, types[PropertyType] do
    argument :uid, types.String
    argument :name, types.String

    resolve byNameOrId.(:properties)
  end

  field :theorems, types[TheoremType] do
    argument :uid, types.String

    resolve byNameOrId.(:theorems)
  end

  field :traitTable, types.String do
    argument :spaceId,    types.String
    argument :propertyId, types.String

    resolve ->(user, args, ctx) {
      TraitTable.new(
        user,
        space_id:    args[:spaceId],
        property_id: args[:propertyId]
      ).to_json
    }
  end
end
