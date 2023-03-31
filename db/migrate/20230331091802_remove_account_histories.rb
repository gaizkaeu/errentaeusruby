class RemoveAccountHistories < ActiveRecord::Migration[7.0]
  def change
    drop_table :account_histories
  end
end
