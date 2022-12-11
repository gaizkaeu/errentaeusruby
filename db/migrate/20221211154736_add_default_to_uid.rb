class AddDefaultToUid < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :uid, :string, :default => ''
  end
end
