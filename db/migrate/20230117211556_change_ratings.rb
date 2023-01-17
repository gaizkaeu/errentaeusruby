class ChangeRatings < ActiveRecord::Migration[7.0]
  def change
    remove_column :organizations, :avg_rating
    add_column :organizations, :five_star_count, :integer, default: 0
    add_column :organizations, :four_star_count, :integer, default: 0
    add_column :organizations, :three_star_count, :integer, default: 0
    add_column :organizations, :two_star_count, :integer, default: 0
    add_column :organizations, :one_star_count, :integer, default: 0
  end
end
