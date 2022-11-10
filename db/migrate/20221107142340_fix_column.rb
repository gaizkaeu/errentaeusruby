class FixColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :documents, :laywer_id, :lawyer_id
  end
end
