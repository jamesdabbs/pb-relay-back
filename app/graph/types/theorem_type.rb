TheoremType = GraphQL::ObjectType.define do
  name 'Theorem'
  description 'A theorem'

  field :uid,         types.String
  field :name,        types.String
  field :preview,     types.String
  field :description, types.String
end
