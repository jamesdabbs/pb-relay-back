class CreateQueryLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :query_logs do |t|
      t.string :schema_name
      t.text :query
      t.text :variables
      t.text :result
      t.text :error

      t.timestamps
    end
  end
end
