class ProofBuilder
  def self.build queries
    # TODO: build map from queries
    proof_to_trait = {}
    trait_to_proof = {}
    DB::Proof.
        select(:id, :trait_id, :theorem_id).
        find_each do |p|
      proof_to_trait[p.id] = p.trait_id
      trait_to_proof[p.trait_id] = [p.theorem_id, []]
    end

    DB::Assumption.
        select(:id, :proof_id, :trait_id).
        find_each do |a|
      trait_id = proof_to_trait.fetch a.proof_id
      trait_to_proof.fetch(trait_id).last.push(a.trait_id)
    end

    new queries, trait_to_proof
  end

  def initialize queries, proof_map
    @queries, @proof_map = queries, proof_map
  end

  def for trait_id
    queue, theorems, traits = [trait_id], Set.new, Set.new

    until queue.empty?
      assumed_id = queue.shift
      theorem_id, trait_ids = @proof_map[assumed_id]
      if theorem_id # deduced
        theorems << theorem_id
        queue += trait_ids
      else # asserted
        traits << assumed_id
      end
    end

    Proof.new(
      @queries.theorems_by_ids(theorems.to_a),
      @queries.traits_by_ids(traits.to_a)
    )
  end

  def proof_count
    @proof_map.size
  end
end
