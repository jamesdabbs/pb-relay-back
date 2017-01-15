QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root for this schema'

  field :space do
    type SpaceType
    argument :id, !types.ID
    resolve ->(obj, args, ctx) {
      DB.find_space args[:id]
    }
  end

  field :property do
    type PropertyType
    argument :id, !types.ID
    resolve ->(obj, args, ctx) {
      DB.find_property args[:id]
    }
  end
end
