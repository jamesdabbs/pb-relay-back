byNameOrId = ->(attr) {
  ->(viewer, args, ctx) {
    scope = viewer.public_send attr
    viewer.filter scope, \
      id:   args[:uid],
      name: args[:name]
  }
}

ViewerType = GraphQL::ObjectType.define do
  name        'Viewer'
  description 'A site user'

  field :spaces, types[SpaceType] do
    argument :uid,  types.String
    argument :name, types.String

    resolve byNameOrId.(:spaces)
  end

  field :properties, types[PropertyType] do
    argument :uid,  types.String
    argument :name, types.String

    resolve byNameOrId.(:properties)
  end

  field :theorems, types[TheoremType] do
    argument :uid, types.String

    resolve byNameOrId.(:theorems)
  end

  # TODO: why can't this be a JSONField?
  field :traitTable, types.String do
    argument :spaceId, types.String

    resolve ->(viewer, args, ctx) {
      opts = {
        space_id: args[:spaceId],
      }.compact

      viewer.universe.trait_table opts
    }
  end
end
