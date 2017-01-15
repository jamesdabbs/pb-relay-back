TopologySchema = GraphQL::Schema.define do
  query QueryType

  id_from_object ->(object, type_definition, query_ctx) {
    # Call your application's UUID method here
    # It should return a string
    GraphQL::Schema::UniqueWithinType.encode(object.class.name, object.id)
  }

  object_from_id ->(id, query_ctx) {
    class_name, item_id = MyApp::GlobalId.decrypt(id)
    # "Post" => Post.find(id)
    Object.const_get(class_name).find(item_id)
  }

  resolve_type ->(obj, ctx) {
    binding.pry
  }
end
