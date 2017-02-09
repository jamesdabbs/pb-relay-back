SpaceType = GraphQL::ObjectType.define do
  name 'Space'
  description 'A topological space'

  interfaces [GraphQL::Relay::Node.interface]
  global_id_field :id

  field :uid,         types.String
  field :name,        types.String
  field :preview,     types.String
  field :description, types.String

  field :traits, types[TraitType] do
    argument :propertyName, types.String

    resolve ->(space, args, ctx) {
      scope = space.traits
      scope = if args[:propertyName]
        prop = Property.find_by name: args[:propertyName]
        scope.where(property_id: prop.id)
      else
        scope.includes(:property)
      end
      scope
    }
  end
end
