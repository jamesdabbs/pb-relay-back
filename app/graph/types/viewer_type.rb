byNameOrId = ->(scope) {
  ->(user, args, ctx) {
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
    argument :uid, types.String
    argument :name, types.String

    resolve byNameOrId.(Space.all)
  end

  field :properties, types[PropertyType] do
    argument :uid, types.String
    argument :name, types.String

    resolve byNameOrId.(Property.all)
  end

  field :theorems, types[TheoremType] do
    argument :uid, types.String

    resolve byNameOrId.(Theorem.all)
  end

  field :traitTable, types.String do
    argument :spaceId,    types.String
    argument :propertyId, types.String

    resolve ->(user, args, ctx) {
      TraitTable.new(
        space_id: args[:spaceId], property_id: args[:propertyId]
      ).to_json
    }
  end
end
