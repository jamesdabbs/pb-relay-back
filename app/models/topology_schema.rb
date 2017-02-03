TopologySchema = GraphQL::Schema.define do
  query QueryType

  id_from_object ->(object, type_definition, query_ctx) {
    GraphQL::Schema::UniqueWithinType.encode(object.class.name, object.id)
  }

  object_from_id ->(id, query_ctx) {
    type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    Object.const_get(type_name).find(item_id)
  }

  resolve_type ->(obj, ctx) {
    {
      Space => SpaceType
    }.fetch obj.class
  }
end
