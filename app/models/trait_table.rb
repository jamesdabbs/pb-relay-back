class TraitTable
  def initialize user, space_id: nil, property_id: nil
    scope = user.traits
    scope = scope.where(space_id:    space_id   ) if space_id
    scope = scope.where(property_id: property_id) if property_id

    @traits, yes = Hash.new, Value.find_by(name: 'True').id

    scope.find_each do |t|
      @traits[t.space_id] ||= {}
      @traits[t.space_id][t.property_id] = {
        value:   t.value_id == yes,
        deduced: t.deduced
      }
    end
  end

  def to_json
    @traits.to_json
  end
end
