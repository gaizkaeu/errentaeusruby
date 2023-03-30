class AddAttributesToTags < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :hex_color, :string
    add_column :tags, :emoji, :string
  end
end
