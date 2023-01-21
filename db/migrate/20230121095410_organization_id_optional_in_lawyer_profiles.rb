class OrganizationIdOptionalInLawyerProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :lawyer_profiles, :organization_id
    add_column :lawyer_profiles, :organization_id, :string, null: true, foreign_key: { to_table: :organizations }
  end
end
