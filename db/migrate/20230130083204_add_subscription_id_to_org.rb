class AddSubscriptionIdToOrg < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :subscription_id, :string
  end
end
