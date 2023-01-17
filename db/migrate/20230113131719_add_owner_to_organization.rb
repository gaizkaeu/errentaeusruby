class AddOwnerToOrganization < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :owner, :string, null: false, foreign_key: { to_table: :users }
  end
end
