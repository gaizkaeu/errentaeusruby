class CreateLawyerProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :lawyer_profiles, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :organization_id, null: false, index: true, foreign_key: { to_table: :organizations }
      t.string :user_id, null: false, index: true, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
