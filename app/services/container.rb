require_relative '../models/db/queries'

class Container
  attr_reader :queries

  def initialize queries: nil, reload: false
    @reload  = reload
    @queries = queries || DB::Queries.new
  end

  def universe
    if @reload
      Universe.new @queries
    else
      @universe ||= Universe.new(@queries)
    end
  end
end
