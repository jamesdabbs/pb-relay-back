QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root for this schema'

  field :viewer do
    type UserType
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
end
