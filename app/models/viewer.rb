class Viewer
  attr_reader :universe

  def initialize universe
    @universe = universe
  end

  def filter scope, opts
    queries.filter scope, opts.compact
  end

  def spaces
    queries.all_spaces
  end

  def properties
    queries.all_properties
  end

  def theorems
    queries.all_theorems
  end

  def short_proof trait
    queries.short_proof trait
  end

  def full_proof trait
    trait_id = queries.lookup_trait trait
    universe.full_proof trait_id
  end

  def traits space:, property_name: nil
    queries.space_traits space, property_name: property_name
  end

  private

  def queries
    universe.queries
  end
end
