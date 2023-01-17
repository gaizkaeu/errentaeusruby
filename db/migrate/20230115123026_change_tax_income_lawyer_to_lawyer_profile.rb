class ChangeTaxIncomeLawyerToLawyerProfile < ActiveRecord::Migration[7.0]
  def change
    remove_column :tax_incomes, :lawyer_id
    add_column :tax_incomes, :lawyer_id, :string, foreign_key: { to_table: :lawyer_profiles }, index: true
  end
end
