class AddProviderAndUidToAccountHistory < ActiveRecord::Migration[7.0]
  def change
    add_column :account_histories, :uid, :string
    add_column :account_histories, :provider, :string
  end
end
