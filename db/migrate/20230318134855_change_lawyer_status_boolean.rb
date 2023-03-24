class ChangeLawyerStatusBoolean < ActiveRecord::Migration[7.0]
  def change
    remove_column :lawyer_profiles, :lawyer_status
    add_column :lawyer_profiles, :on_duty, :boolean, default: false
  end
end
