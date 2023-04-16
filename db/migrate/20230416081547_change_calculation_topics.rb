class ChangeCalculationTopics < ActiveRecord::Migration[7.0]
  def change
    remove_column :calculation_topics, :attribute_types
    remove_column :calculation_topics, :questions
    remove_column :calculation_topics, :variables
  end
end
