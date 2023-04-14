class AddCallTimeToCalls < ActiveRecord::Migration[7.0]
  def change
    add_column :call_contacts, :call_time, :datetime
  end
end
