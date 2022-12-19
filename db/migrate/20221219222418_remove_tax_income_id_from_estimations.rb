class RemoveTaxIncomeIdFromEstimations < ActiveRecord::Migration[7.0]
  def change
    remove_column :estimations, :tax_income_id
  end
end
