class AddRequiredDocumentNumberToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :document_number, :integer
  end
end
