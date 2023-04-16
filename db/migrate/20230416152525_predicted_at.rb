class PredictedAt < ActiveRecord::Migration[7.0]
  def change
    add_column :calculations, :predicted_at, :datetime
  end
end
