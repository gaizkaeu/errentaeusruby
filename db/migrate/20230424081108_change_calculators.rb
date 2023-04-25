class ChangeCalculators < ActiveRecord::Migration[7.0]
  def change
    remove_column :calculators, :correct_rate

    add_column :calculators, :calculator_status, :string
  end
end
