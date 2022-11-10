class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.integer :state
      t.string :name
      t.references :tax_income, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true, foreign_key: { to_table: 'users' }
      t.references :laywer, null: false, foreign_key: true, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
