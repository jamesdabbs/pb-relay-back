class Property < Dry::Struct
  attribute :uid,         T::String
  attribute :name,        T::String
  attribute :description, T::String.optional

  include Dry::Equalizer(:uid, :name, :description)

  def _id;  uid; end
  def slug; H.slug name; end

  def to_s
    %|<Property(#{name})>|
  end
end
