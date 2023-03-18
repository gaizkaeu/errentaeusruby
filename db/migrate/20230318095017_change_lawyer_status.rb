class ChangeLawyerStatus < ActiveRecord::Migration[7.0]
  def change

    remove_column :lawyer_profiles, :lawyer_status
    add_column :lawyer_profiles, :lawyer_status, :string, default: 'off_duty'
  end
end
