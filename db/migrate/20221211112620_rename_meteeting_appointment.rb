class RenameMeteetingAppointment < ActiveRecord::Migration[7.0]
  def change
    rename_column :appointments, :method, :meeting_method
  end
end
