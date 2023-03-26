class ChangeOrgStatusToString < ActiveRecord::Migration[7.0]
  def change
    remove_column :organizations, :status
    add_column :organizations, :status, :string, null: false, default: 'not_subscribed'
  end
end
