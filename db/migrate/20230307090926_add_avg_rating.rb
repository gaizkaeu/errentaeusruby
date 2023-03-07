class AddAvgRating < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :avg_rating, :float, default: 0.0
  end
end
