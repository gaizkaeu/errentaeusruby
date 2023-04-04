class AddDarkHexColorTag < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :dark_hex_color, :string
  end
end
