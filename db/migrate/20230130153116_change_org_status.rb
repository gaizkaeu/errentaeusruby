class ChangeOrgStatus < ActiveRecord::Migration[7.0]
  def change
    remove_column :organizations, :featured
    add_column :organizations, :status, :integer, default: 0
  end
end
