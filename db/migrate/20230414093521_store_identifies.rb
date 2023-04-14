class StoreIdentifies < ActiveRecord::Migration[7.0]
  def change
    add_column :account_identities, :info, :json, default: "{}"
    add_column :account_identities, :credentials, :json, default: "{}"
    add_column :account_identities, :extra, :json, default: "{}"
  end
end
