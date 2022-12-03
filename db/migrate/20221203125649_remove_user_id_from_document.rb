class RemoveUserIdFromDocument < ActiveRecord::Migration[7.0]
  def change
    remove_column :documents, :user_id
  end
end
