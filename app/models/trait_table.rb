class TraitTable
  def self.build
    traits = {}

    Trait.find_each do |t|
      traits[t.space_id] ||= {}
      traits[t.space_id][t.property_id] = {
        value:   t.value_id == Universe::TrueId,
        deduced: t.deduced
      }
    end

    new traits
  end

  def initialize traits
    @traits = traits
  end

  def filter space_id: nil
    h = @traits
    h = h.select { |k,v| space_id.include?(k) } if space_id
    h
  end
end
