class AddDotVisualizationToCalculator < ActiveRecord::Migration[7.0]
  def change
    add_column :calculators, :dot_visualization, :text
  end
end
