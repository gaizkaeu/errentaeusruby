class AddDefaultOuputCalculation < ActiveRecord::Migration[7.0]
  def change
    change_column :calculations, :output, :jsonb, default: {}
  end
end
