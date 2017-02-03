class QueryLog < ApplicationRecord
  serialize :variables, JSON
  serialize :result,    JSON

  def self.run schema, query, variables: {}
    # FIXME: schema name
    q = create! schema_name: 'TopologySchema', query: query, variables: variables
    result = schema.execute query, variables: variables
    q.update! result: result
    result
  rescue => e
    q.update! error: e
    raise
  ensure
    truncate!
  end

  def self.truncate!
    where('created_at < ?', 1.day.ago).delete_all
  end

  def rerun
    schema.execute query, variables: variables
  end

  def schema
    schema_name.constantize
  end
end
