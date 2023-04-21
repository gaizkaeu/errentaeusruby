class AddAttributesToTopics < ActiveRecord::Migration[7.0]
  def change
    add_column :calculation_topics, :attributes_training, :string, array: true, default: []
    add_column :calculation_topics, :variables, :jsonb, default: {}
  end
end
