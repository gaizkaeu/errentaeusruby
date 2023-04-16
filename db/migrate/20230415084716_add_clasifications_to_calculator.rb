class AddClasificationsToCalculator < ActiveRecord::Migration[7.0]
  def change
    add_column :calculators, :clasifications, :jsonb, default: {}
  end
end
