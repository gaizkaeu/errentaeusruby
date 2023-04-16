class AddPriceResultToCalculation < ActiveRecord::Migration[7.0]
  def change
    add_column :calculations, :price_result, :integer
  end
end
