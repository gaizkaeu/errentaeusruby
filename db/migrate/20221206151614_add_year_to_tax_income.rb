class AddYearToTaxIncome < ActiveRecord::Migration[7.0]
  def change
    add_column :tax_incomes, :year, :integer
  end
end
