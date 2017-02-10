TheoremType = GraphQL::ObjectType.define do
  name        'Theorem'
  description 'A theorem relating properties'

  field :uid,         types.String
  field :name,        JSONType
  field :preview,     types.String
  field :description, types.String
end
