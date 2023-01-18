class AddIndexOnOrgAndUser < ActiveRecord::Migration[7.0]
  def change
    add_index :reviews, %i[organization_id user_id], unique: true
  end
end
