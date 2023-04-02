class AddStartAtToCalls < ActiveRecord::Migration[7.0]
  def change
    add_column :call_contacts, :start_at, :datetime
    add_column :call_contacts, :end_at, :datetime

    add_column :call_contacts, :duration, :integer, null: false, default: -1
  end
end
