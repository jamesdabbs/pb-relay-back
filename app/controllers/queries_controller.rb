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
    log = QueryLog.find params[:id]
    render json: log.rerun
  end

  def schema
    query GraphQL::Introspection::INTROSPECTION_QUERY
  end

  private

  def query q
    vars = params[:variables] || {}
    render json: QueryLog.run(TopologySchema, q, variables: vars)
  end
end
