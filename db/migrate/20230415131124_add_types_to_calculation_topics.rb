class AddTypesToCalculationTopics < ActiveRecord::Migration[7.0]
  def change
    add_column :calculation_topics, :attribute_types, :jsonb, default: {}
  end
end
