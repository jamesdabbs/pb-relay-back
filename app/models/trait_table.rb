class TraitTable
  def self.build queries
    traits = {}

    queries.all_traits.each do |t|
      traits[t.space.uid] ||= {}
      traits[t.space.uid][t.property.uid] = {
        value:   t.value,
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
