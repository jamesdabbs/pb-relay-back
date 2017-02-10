class Universe
  TrueId = Value.find_by!(name: "True").id

  def initialize
    @proof_builder = ProofBuilder.build
    @trait_table   = TraitTable.build
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

  Prime = new
  def self.prime
    ENV["FORCE_RELOAD"] ? new : Prime
  end
end
