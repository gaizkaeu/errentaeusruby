class AddPrecissionPercentaje < ActiveRecord::Migration[7.0]
  def change
    add_column :calculators, :correct_rate, :integer, default: -1
    add_column :calculators, :sample_count, :integer, default: -1
  end
end
