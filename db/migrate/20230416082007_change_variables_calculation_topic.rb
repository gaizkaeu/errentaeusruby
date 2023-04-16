class ChangeVariablesCalculationTopic < ActiveRecord::Migration[7.0]
  def change
    remove_column :calculation_topics, :attributes_training

    add_column :calculation_topics, :prediction_attributes, :jsonb, default: {}
  end
end
