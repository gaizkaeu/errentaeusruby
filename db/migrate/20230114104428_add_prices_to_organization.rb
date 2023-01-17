class AddPricesToOrganization < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :prices, :jsonb, default: {}
  end
end
