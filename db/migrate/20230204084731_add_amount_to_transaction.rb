class AddAmountToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :amount, :integer, null: false
    add_column :transactions, :amount_capturable, :integer, null: false
  end
end
