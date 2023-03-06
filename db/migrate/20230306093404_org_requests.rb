class OrgRequests < ActiveRecord::Migration[7.0]
  def change

    create_table :organization_requests, id: false do |t|
      t.string :id, primary_key: true
      t.string :name
      t.string :email
      t.string :phone
      t.string :website
      t.string :city
      t.string :province
      t.timestamps
    end
  end
end
