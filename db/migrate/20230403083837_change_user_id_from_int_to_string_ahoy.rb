class ChangeUserIdFromIntToStringAhoy < ActiveRecord::Migration[7.0]
  def change

    change_column :ahoy_events, :user_id, :string
    change_column :ahoy_visits, :user_id, :string
  end
end
