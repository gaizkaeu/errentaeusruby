class AddColorsToCalculationTopics < ActiveRecord::Migration[7.0]
  def change
    add_column :calculation_topics, :colors, :string, default: "bg-gradient-to-r from-pink-500 via-red-500 to-yellow-500"
  end
end
