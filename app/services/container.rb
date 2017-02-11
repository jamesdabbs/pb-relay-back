require_relative '../models/db/queries'

class Container
  def initialize reload=false
    @reload  = reload
    @queries = DB::Queries.new
  end

  def universe
    if @reload
      Universe.new @queries
    else
      @universe ||= Universe.new(@queries)
    end
  end
end
