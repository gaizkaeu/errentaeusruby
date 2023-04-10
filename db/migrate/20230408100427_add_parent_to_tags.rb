class AddParentToTags < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :parent_tag, foreign_key: { to_table: :tags }, index: true
  end
end
