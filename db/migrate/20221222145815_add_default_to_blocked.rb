class AddDefaultToBlocked < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :blocked, :boolean, default: false, allow_nil: false
  end
end
