class Refactor < ActiveRecord::Migration[7.0]
  def change

    remove_column :organizations, :owner_id
    remove_column :lawyer_profiles, :organization_id
    remove_column :lawyer_profiles, :org_status
    remove_column :lawyer_profiles, :tax_income_count
  end
end
