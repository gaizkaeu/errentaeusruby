class AddPriceRangeToOrganization < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :price_range, :integer
  end
end
