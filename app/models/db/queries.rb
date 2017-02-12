module DB
  class Queries
    def filter scope, opts
      scope.where opts
    end

    def all_spaces
      DB::Space.all.map(&:to_value)
    end

    def all_properties
      DB::Property.all.map(&:to_value)
    end

    def all_theorems
      DB::Theorem.all.map do |t|
        t.to_value formula: ->(f) { hydrate_formula f }
      end
    end

    def all_traits
      DB::Trait.all.map { |t| t.to_value properties: _properties, spaces: _spaces }
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
      scope = DB::Trait.where(space_id: space._id).includes :property
      if property_name
        prop = DB::Property.find_by name: property_name
        scope = scope.where(property_id: prop.id)
      end

      scope.find_each.map do |t|
        t.to_value spaces: _spaces, properties: _properties
      end
    end

    def theorems_by_ids ids
      Theorem.where(id: ids).map do |t|
        t.to_value formula: ->(f) { hydrate_formula f }
      end
    end

    def traits_by_ids ids
      Trait.where(id: ids).map { |t| t.to_value spaces: _spaces, properties: _properties }
    end

    private

    def index key, coll
      coll.each_with_object({}) do |item, hash|
        hash[item.public_send key] = item
      end
    end

    def _spaces
      @_spaces ||= index :_id, all_spaces
    end

    def _properties
      @_properties ||= index :_id, all_properties
    end

    def hydrate_formula f
      Formula.from_json(f).map do |p,v|
        [_properties.fetch(p.to_i), v == Universe.true_id]
      end
    end
  end
end
