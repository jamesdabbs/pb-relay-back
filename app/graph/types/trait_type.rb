TraitType = GraphQL::ObjectType.define do
  name 'Trait'
  description 'Properties posessed by a specific space'

  interfaces [GraphQL::Relay::Node.interface]
  global_id_field :id

  field :space,    SpaceType
  field :property, PropertyType
  field :value,    ValueEnum

  field :description, types.String
  field :deduced,     types.Boolean

  field :proof, JSONType do
    argument :full, types.Boolean

    resolve ->(trait, args, ctx) {
      # TODO: figure out the right way to customize `QueryType#node` to set this there
      ctx[:viewer] ||= Viewer.new(Rails.configuration.container.universe)
      if args[:full]
        ctx[:viewer].full_proof trait
      else
        ctx[:viewer].short_proof trait
      end
    }
  end
end
