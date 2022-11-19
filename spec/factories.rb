FactoryBot.define do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    factory :user, class: "Api::V1::User" do
      first_name { "John" }
      last_name  { "Doe" }
      email { generate(:email) }
      password { "test123" }
      password_confirmation { "test123" }
    end
    factory :tax_income, class: "Api::V1::TaxIncome" do
      user
    end
  end