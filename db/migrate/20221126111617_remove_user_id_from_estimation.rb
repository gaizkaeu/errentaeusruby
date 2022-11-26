class RemoveUserIdFromEstimation < ActiveRecord::Migration[7.0]
  def change
    remove_column :estimations, :user_id
  end
end
