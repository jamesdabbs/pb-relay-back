class QueryLog < ApplicationRecord
  serialize :variables, JSON
  serialize :result,    JSON

  def self.run schema, query, variables: {}
    truncate!

    schema_name = 'TopologySchema'
    if schema_name.constantize != schema
      raise "FIXME: introspect schema_name?"
    end

    q = create! schema_name: schema_name, query: query, variables: variables
    result = schema.execute query, variables: variables
    q.log result: result

    [result, q]
  rescue => e
    q.log error: e
    raise
  end

  def self.truncate!
    where('created_at < ?', 1.day.ago).delete_all
  end

  def rerun
    self.class.run schema, query, variables: variables
  end

  def schema
    schema_name.constantize
  end

  def log opts
    Rails.logger.info "Logging #{id}: #{opts.keys}"
    Rails.logger.silence { update! opts }
  end
end
