class AddOwnerRelations < ActiveRecord::Migration[7.0]
  def change
    remove_column :organizations, :owner, :string
    add_column :organizations, :owner_id, :string, null: false
    add_foreign_key :organizations, :users, column: :owner_id, primary_key: :id
    add_index :organizations, :owner_id
  end
end
