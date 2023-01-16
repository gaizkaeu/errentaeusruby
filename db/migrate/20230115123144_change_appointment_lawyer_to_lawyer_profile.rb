class ChangeAppointmentLawyerToLawyerProfile < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :lawyer_id
    add_column :appointments, :lawyer_id, :string, foreign_key: { to_table: :lawyer_profiles }, index: true
  end
end
