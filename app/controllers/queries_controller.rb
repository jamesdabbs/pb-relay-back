class QueriesController < ApplicationController
  def index
    @logs = QueryLog.order id: :desc
  end

  def show
    @log = QueryLog.find params[:id]
  end

  def last
    @log = QueryLog.last
    render :show
  end

  def create
    query params[:query]
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
