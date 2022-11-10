class AddAttachmentsToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :export_status, :integer
    add_reference :documents, :exported_by, foreign_key: { to_table: 'users' }
  end
end
