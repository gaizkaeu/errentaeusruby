class AddNoNullContraintToLawyerProfile < ActiveRecord::Migration[7.0]
  def change
    change_column_null :lawyer_profiles, :organization_id, false
    add_index :lawyer_profiles, [:organization_id, :user_id], unique: true
  end
end
