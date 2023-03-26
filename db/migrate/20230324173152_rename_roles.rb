class RenameRoles < ActiveRecord::Migration[7.0]
  def change
    rename_column :users_roles, :user_record_id, :user_id
  end
end
