ValueEnum = GraphQL::EnumType.define do
  name        "Value"
  description "Values that a Trait might have"

  value true,  "This space posses the given (boolean) property"
  value false, "The opposite of `true`"
end
