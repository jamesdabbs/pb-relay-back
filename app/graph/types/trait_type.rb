TraitType = GraphQL::ObjectType.define do
  name 'Trait'
  description 'Properties posessed by a specific space'

  interfaces [GraphQL::Relay::Node.interface]
  global_id_field :id

  field :space,    SpaceType
  field :property, PropertyType
  field :value, ValueEnum do
    resolve ->(obj, args, ctx) {
      obj.value.name
    }
  end

  field :description, types.String
  field :deduced,     types.Boolean

  field :proof, JSONType do
    argument :full, types.Boolean

    resolve ->(trait, args, ctx) {
      if !args[:full]
        # TODO: why isn't ctx[:viewer] being set sometimes? node entrypoint?
        Universe.prime.full_proof trait
      else
        trait.proof
      end
    }
  end
end
