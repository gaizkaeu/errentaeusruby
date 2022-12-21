class RemoveCreatedUpdatedFromAccountHistories < ActiveRecord::Migration[7.0]
  def change
    remove_column :account_histories, :created_at
    remove_column :account_histories, :updated_at
  end
end
