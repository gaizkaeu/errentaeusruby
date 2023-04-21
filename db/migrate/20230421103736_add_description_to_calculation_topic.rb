class AddDescriptionToCalculationTopic < ActiveRecord::Migration[7.0]
  def change
    add_column :calculation_topics, :description, :string
  end
end
