class Formula
  class Compound
    attr_reader :subs

    def initialize subs
      @subs = subs
    end

    def inspect
      _name = self.class.name.split('::').last
      %|<#{_name}(#{subs.map(&:inspect).join(' ')})>|
    end

    def map &block
      self.class.new(@subs.map { |f| f.map(&block) })
    end

    def == other
      self.class == other.class && subs == other.subs
    end
  end

  class And < Compound
    def and; subs; end

    def to_yaml
      { "and" => subs.map(&:to_yaml) }
    end
  end

  class Or < Compound
    def or; subs; end

    def to_yaml
      { "or" => subs.map(&:to_yaml) }
    end
  end

  class Atom
    attr_reader :property, :value

    include Dry::Equalizer(:property, :value)

    def initialize prop, val
      @property, @value = prop, val
    end

    def map &block
      p,v = if block.arity == 2
        block.call property, value
      else
        block.call property
      end
      v ||= value
      self.class.new p, v
    end

    def inspect
      %|<Atom(#{property}=#{value})>|
    end

    def to_yaml
      { property => value }
    end
  end

  def self.atom p, v
    Atom.new p, v
  end

  def self.and *subs
    And.new subs
  end

  def self.or *subs
    Or.new subs
  end

  def self.to_yaml f
    case f
    when And
      { "and" => f.subs.map { |s| to_yaml s } }
    when Or
      { "or" => f.subs.map { |s| to_yaml s } }
    else
      { f.property => (f.value == Universe.true_id) }
    end
  end

  def self.from_json f
    k,v = f.first
    if k.to_s == "and"
      And.new v.map { |sub| from_json sub }
    elsif k.to_s == "or"
      Or.new v.map { |sub| from_json sub }
    else
      Atom.new k, v
    end
  end
end
