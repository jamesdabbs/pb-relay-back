class QueriesController < ApplicationController
  def index
    @logs = QueryLog.order id: :desc
  end

  def show
    @log = if params[:id] == 'last'
      QueryLog.last
    else
      QueryLog.find params[:id]
    end
  end

  def create
    query params[:query]
  end

  def rerun
    _, log = QueryLog.find(params[:id]).rerun
    redirect_to query_path(log)
  end

  def schema
    query GraphQL::Introspection::INTROSPECTION_QUERY
  end

  private

  def query q
    vars = params[:variables] || {}
    result, _ = QueryLog.run(TopologySchema, q, variables: vars)
    render json: result
  end
end
