module DB
  class Space < ApplicationRecord
    has_many :traits
  end

  class Property < ApplicationRecord
    has_many :traits
  end

  class Trait < ApplicationRecord
    belongs_to :space
    belongs_to :property
  end

  class Store
    def initialize
      @data = {
        spaces:     {},
        properties: {},
        traits:     {},
        theorems:   {}
      }
    end

    def fetch_cached
      Space.find_each do |s|
        @data[:spaces][s.id] = { name: s.name }
      end
      Property.find_each do |p|
        @data[:properties][p.id] = { name: p.name }
      end
      Traits.find_each do |t|
        @data[:traits][t.id] = { space_id: t.space_id, property_id: t.property_id, value: value }
      end
    end
  end

  class << self
    def store
      @store ||= Store.new
    end

    def find_space id
      s = DB::Space.find id
      ts = s.traits.includes :property

      traits = ts.map do |t|
        ::Trait.new t.id, s, t.property, t.value, t.description
      end

      ::Space.new s.id, s.name, s.description, []
    end

    def find_property id
      Property.find id
    end
  end
end
