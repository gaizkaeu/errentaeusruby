class RefactorAppointments < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :tax_income_id
    rename_column :appointments, :client_id, :user_id
    remove_column :appointments, :lawyer_id
    add_reference :appointments, :organization_membership, type: :string, optional: true
    add_reference :appointments, :organization, type: :string
  end
end
