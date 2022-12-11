class Prepareuid < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :provider, :string, :default => 'email'
    Api::V1::User.reset_column_information

    # finds all existing users and updates them.
    # if you change the default values above you'll also have to change them here below:
    Api::V1::User.find_each do |user|
      user.uid = user.email
      user.provider = 'email'
      user.save!
    end

    # to speed up lookups to these columns:
    add_index :users, [:uid, :provider], unique: true
  end
end
