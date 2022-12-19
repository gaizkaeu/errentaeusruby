class AddReferencesFromTaxIncome < ActiveRecord::Migration[7.0]
  def change
    add_reference :tax_incomes, :estimation, index: true, foreign_key: true
  end
end
