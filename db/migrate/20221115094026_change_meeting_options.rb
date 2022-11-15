class ChangeMeetingOptions < ActiveRecord::Migration[7.0]
  def change
    change_column :appointments, :method, :string
  end
end
