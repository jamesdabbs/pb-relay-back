module DB
  class Queries
    # TODO: all of these methods should return value objects, not ActiveRecords
    def filter scope, opts
      scope.where opts
    end

    def all_spaces
      DB::Space.all
    end

    def all_properties
      DB::Property.all
    end

    def all_theorems
      DB::Theorem.all
    end

    def all_traits
      DB::Trait.all
    end

    def lookup_trait trait
      DB::Trait.find_by(
        space_id:    trait.space.uid,
        property_id: trait.property.uid
      ).try :id
    end

    def short_proof trait
      p = DB::Proof.find_by trait_id: lookup_trait(trait)
      return unless p
      ::Proof.new([p.theorem], p.traits.includes(:property))
    end

    def space_traits space, property_name: nil
      scope = space.traits.includes(:property)
      if property_name
        prop = DB::Property.find_by name: property_name
        scope = scope.where(property_id: prop.id)
      end

      # TODO: should be passing this value object around throughout ...
      s = ::Space.from_db(space)
      scope.find_each.map do |t|
        ::Trait.new(
          uid:         t.id,
          space:       s,
          property:    ::Property.from_db(t.property),
          description: t.description,
          value:       t.value_id == Universe.true_id
        )
      end
    end

    def theorems_by_ids ids
      Theorem.where id: ids
    end

    def traits_by_ids ids
      Trait.where id: ids
    end
  end
end
