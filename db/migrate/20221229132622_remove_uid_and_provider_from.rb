class RemoveUidAndProviderFrom < ActiveRecord::Migration[7.0]
  def change
    remove_column :account_histories, :uid
    remove_column :account_histories, :provider
  end
end
