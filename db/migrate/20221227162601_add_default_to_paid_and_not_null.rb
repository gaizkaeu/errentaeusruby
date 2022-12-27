class AddDefaultToPaidAndNotNull < ActiveRecord::Migration[7.0]
  def change
    execute 'UPDATE tax_incomes SET paid = false WHERE paid IS NULL'
    change_column :tax_incomes, :paid, :boolean, default: false, null: false
  end
end
