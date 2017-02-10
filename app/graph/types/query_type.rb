QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root for this schema'

  field :viewer do
    type ViewerType
    resolve ->(q, args, ctx) {
      ctx[:viewer] = Viewer.new(Universe.prime)
    }
  end

  field :node, GraphQL::Relay::Node.field
end
