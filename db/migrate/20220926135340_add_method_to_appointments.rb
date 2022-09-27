class AddMethodToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :method, :integer
  end
end
