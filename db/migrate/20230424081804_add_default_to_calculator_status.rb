class AddDefaultToCalculatorStatus < ActiveRecord::Migration[7.0]
  def change
    change_column :calculators, :calculator_status, :string, default: 'error', null: false
  end
  
end
