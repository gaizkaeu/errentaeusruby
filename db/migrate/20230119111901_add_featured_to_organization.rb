class AddFeaturedToOrganization < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :featured, :integer, default: 0
    add_column :organizations, :province, :string, default: ''
    add_column :organizations, :city, :string, default: ''
    add_column :organizations, :street, :string, default: ''
    add_column :organizations, :postal_code, :string, default: ''
    add_column :organizations, :country, :string, default: ''
  end
end
