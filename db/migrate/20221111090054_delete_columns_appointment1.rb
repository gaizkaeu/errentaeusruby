class DeleteColumnsAppointment1 < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :client_id
    remove_column :appointments, :lawyer_id
  end
end
