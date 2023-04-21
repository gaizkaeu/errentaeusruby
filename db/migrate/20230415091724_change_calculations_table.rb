class ChangeCalculationsTable < ActiveRecord::Migration[7.0]
  def change

    remove_column :calculations, :organization_id
    change_column :calculations, :user_id, :string, null: true
  end
end
