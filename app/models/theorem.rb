class Theorem < Dry::Struct
  attribute :uid,         T::String
  attribute :antecedent,  T::Object # TODO
  attribute :consequent,  T::Object
  attribute :description, T::String

  include Dry::Equalizer(:uid, :antecedent, :consequent, :description)

  def _id;  uid; end
  def slug; H.slug name; end
end
