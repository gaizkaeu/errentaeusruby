class RenameColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :calculators, :clasifications, :classifications
  end
end
