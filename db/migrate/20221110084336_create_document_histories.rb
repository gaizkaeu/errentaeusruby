class CreateDocumentHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :document_histories do |t|
      t.references :document, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :action

      t.timestamps
    end
  end
end
