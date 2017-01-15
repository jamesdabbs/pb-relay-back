class GraphController < ApplicationController
  def ql
    query TopologySchema
  end

  private

  def query schema
    vars = params[:variables] || {}
    result = schema.execute params[:query], variables: vars
    render json: result
  end
end
