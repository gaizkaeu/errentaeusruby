class AddUniqunessMigrationForLawyerProfile < ActiveRecord::Migration[7.0]
  def change
    remove_index :lawyer_profiles, :user_id
    add_index :lawyer_profiles, :user_id, unique: true
  end
end
