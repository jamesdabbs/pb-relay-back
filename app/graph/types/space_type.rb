SpaceType = GraphQL::ObjectType.define do
  name 'Space'
  description 'A topological space'

  interfaces [GraphQL::Relay::Node.interface]
  global_id_field :id

  field :uid,         types.String
  field :name,        types.String
  field :slug,        types.String
  field :description, types.String

  connection :traits, TraitType.connection_type do
    argument :propertySearch, types.String

    resolve ->(space, args, ctx) {
      scope = space.traits
      if args[:propertySearch]
        scope = scope.
                  joins(:property).
                  where('properties.name ILIKE ?', "%#{args[:propertySearch]}%")
      end
      scope
    }
  end

  field :trait, TraitType do
    argument :propertyId, !types.String
    resolve ->(space, args, ctx) {
      # TODO: clean up
      p = Property.lookup args[:propertyId]
      space.traits.find_by property_id: p.id
    }
  end
end
