class CreateTaxIncomes < ActiveRecord::Migration[7.0]
  def change
    create_table :tax_incomes do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :paid
      t.integer :status
      t.float :price

      t.timestamps
    end
  end
end
