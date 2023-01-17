class AddOrganizationToReview < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :organization_id, :string, foreign_key: { to_table: :organizations}, null: false
  end
end
