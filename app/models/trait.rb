class Trait < ApplicationRecord
  belongs_to :space
  belongs_to :property
  belongs_to :value

  default_scope -> { order property_id: :asc, space_id: :asc }

  def proof
    p = Proof.find_by trait_id: id
    return unless p
    p.to_json
  end

  def full_proof
    p = Proof.find_by trait_id: id
    return unless p
    ProofBuilder.new(p).to_json
  end
end
