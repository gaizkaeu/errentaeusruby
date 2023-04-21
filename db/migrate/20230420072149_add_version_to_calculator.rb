class AddVersionToCalculator < ActiveRecord::Migration[7.0]
  def change
    add_column :calculators, :version, :integer, default: 0
    add_column :calculations, :calculator_version, :integer, default: 0

  end
end
