class AddPaymentToTaxIncome < ActiveRecord::Migration[7.0]
  def change
    add_column :tax_incomes, :payment, :string, null: true
  end
end
