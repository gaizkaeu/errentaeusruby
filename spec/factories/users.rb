FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :password do |n|
    "password#{n}"
  end

  factory :account do
    email { generate(:email) }
    password { generate(:password) }
    status { 'verified' }
  end
  factory :user, class: 'Api::V1::User' do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    phone { Faker::PhoneNumber.cell_phone }
    account
  end

  factory :admin_user, parent: :user do
    after(:create) { |user| user.add_role(:admin) }
  end
end
