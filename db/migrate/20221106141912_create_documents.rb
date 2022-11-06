class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.integer :status
      t.string :name
      t.string :description
      t.references :tax_income, null: false, foreign_key: true

      t.timestamps
    end
  end
end
