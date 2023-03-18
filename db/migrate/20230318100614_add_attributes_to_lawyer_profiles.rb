class AddAttributesToLawyerProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :lawyer_profiles, :email, :string
    add_column :lawyer_profiles, :phone, :string

  end
end
