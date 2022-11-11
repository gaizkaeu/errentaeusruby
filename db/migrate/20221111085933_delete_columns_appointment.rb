class DeleteColumnsAppointment < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :client_id, :lawyer_id
  end
end
