class AddDescriptionToDocumentHistory < ActiveRecord::Migration[7.0]
  def change
    add_column :document_histories, :description, :string
  end
end
