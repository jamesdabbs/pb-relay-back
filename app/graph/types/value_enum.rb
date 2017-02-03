ValueEnum = GraphQL::EnumType.define do
  name        "Value"
  description "Values that a Trait might have"

  value "True", "True", value: "True"
  value "False", "False", value: "False"
end
