class Universe
  attr_reader :queries

  def self.true_id
    @true_id ||= DB::Value.find_by(name: "True").id
  end

  def initialize queries
    @queries       = queries
    @proof_builder = ProofBuilder.build(queries)
    @trait_table   = TraitTable.build(queries)
  end

  def inspect
    "<Universe(#{@proof_builder.proof_count} proofs)>"
  end

  def full_proof trait
    @proof_builder.for trait
  end

  def trait_table opts={}
    @trait_table.filter(opts).to_json
  end
end
