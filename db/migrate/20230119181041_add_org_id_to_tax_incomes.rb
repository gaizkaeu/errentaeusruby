class AddOrgIdToTaxIncomes < ActiveRecord::Migration[7.0]
  def change
    add_column :tax_incomes, :organization_id, :string, null: false, foreign_key: { to_table: :organizations}
    add_index :tax_incomes, :organization_id
  end
end
