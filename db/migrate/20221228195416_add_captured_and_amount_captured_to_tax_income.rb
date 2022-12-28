class AddCapturedAndAmountCapturedToTaxIncome < ActiveRecord::Migration[7.0]
  def change
    add_column :tax_incomes, :captured, :boolean, default: false
    add_column :tax_incomes, :amount_captured, :integer, default: 0
  end
end
