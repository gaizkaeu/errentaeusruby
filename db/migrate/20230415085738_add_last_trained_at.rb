class AddLastTrainedAt < ActiveRecord::Migration[7.0]
  def change
    add_column :calculators, :last_trained_at, :datetime
  end
end
