class RenameColumnFromTaxIncomes < ActiveRecord::Migration[7.0]
  def change
    rename_column :tax_incomes, :user_id, :client_id
  end
end
