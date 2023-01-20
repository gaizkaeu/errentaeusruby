class AddTaxIncomeCountToLawyer < ActiveRecord::Migration[7.0]
  def change
    add_column :lawyer_profiles, :tax_income_count, :integer, default: 0
  end
end
