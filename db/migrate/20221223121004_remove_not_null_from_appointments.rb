class RemoveNotNullFromAppointments < ActiveRecord::Migration[7.0]
  def change
    change_column_null :appointments, :tax_income_id, true
  end
end
