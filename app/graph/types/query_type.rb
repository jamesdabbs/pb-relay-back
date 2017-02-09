QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root for this schema'

  field :viewer do
    type ViewerType
    resolve ->(*_) {
      Viewer.new
    }
  end

  field :node, GraphQL::Relay::Node.field

  field :space do
    type SpaceType
    argument :id, !types.ID
    resolve ->(obj, args, ctx) {
      Space.lookup args[:id]
    }
  end

  field :property do
    type PropertyType
    argument :slug, !types.String
    resolve ->(obj, args, ctx) {
      Property.lookup args[:slug]
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
