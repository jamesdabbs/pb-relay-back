class ProofBuilder
  # TODO: better caching of these
  Assumptions, Proofs = {}, {}

  Assumption.find_each do |a|
    Assumptions[a.proof_id] ||= []
    Assumptions[a.proof_id].push a.trait_id
  end

  Proof.find_each do |p|
    Proofs[p.trait_id] = [p.id, p.theorem_id]
  end

  def initialize proof
    @root = proof.trait_id
    @result = {
      theorems: Set.new,
      traits:   Set.new
    }

    add_trait id: @root

    @theorems = Theorem.where id: @result[:theorems].to_a
    @traits   = Trait.where   id: @result[:traits].to_a
  end

  def add_trait id:
    return if @result[:traits].include?(id)

    proof_id, theorem_id = Proofs[id]
    if proof_id # deduced
      @result[:theorems] << theorem_id
      Assumptions.fetch(proof_id).each { |tid| add_trait id: tid }
    else # asserted
      @result[:traits] << id
    end
  end

  def to_json
    Proof.serialize @theorems, @traits
  end
end
