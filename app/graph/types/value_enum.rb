ValueEnum = GraphQL::EnumType.define do
  name        "Value"
  description "Values that a Trait might have"

  value "True", "True", value: true
  value "False", "False", value: false
end
