class AddStatusToLawyerProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :lawyer_profiles, :org_status, :integer, default: 0, null: false
    add_column :lawyer_profiles, :lawyer_status, :integer, default: 0, null: false
  end
end
