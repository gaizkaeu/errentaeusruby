class Reviews < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :updated_at
    add_index :reviews, :organization_id
    add_column :reviews, :user_id, :string, foreign_key: { to_table: :users}, null: false
    add_index :reviews, :user_id
  end
end
