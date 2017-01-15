class Database
  def initialize
    @data = {}
  end

  def find_space id
    find Space, id
  end

  def find_property id
    find Property, id
  end

  def add obj
    self[obj.class][obj.id.to_s] = obj
  end

  private

  def [] klass
    @data[klass] ||= {}
  end

  def all klass
    self[klass].values
  end

  def find klass, id
    self[klass][id.to_s]
  end
end

DB = Database.new.tap do |d|
  s = Space.new 1, "Space", "A Space", []
  p = Property.new 1, "Property", "A Property", []

  traits = [
    Trait.new(1, s, p, true, "because"),
    Trait.new(2, s, p, false, "because")
  ]

  s.traits = traits
  p.traits = traits

  d.add s
  d.add p
end
