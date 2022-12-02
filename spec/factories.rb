FactoryBot.define do
    sequence :email do |n|
      "person#{n}@example.com"
    end


    factory :user, class: "Api::V1::User", aliases: [:client] do
      first_name { "My Excellent" }
      last_name  { "Lawyer" }
      email { generate(:email) }
      password { "test123" }
      password_confirmation { "test123" }
      confirmed_at { "04-07-2002" }
    end

    factory :lawyer, class: "Api::V1::User" do
      first_name { "Carolina" }
      last_name  { "Doe" }
      email { generate(:email) }
      password { "test123" }
      password_confirmation { "test123" }
      confirmed_at { "04-07-2002" }
      account_type { "lawyer" }
    end

    factory :tax_income, class: "Api::V1::TaxIncome" do
      client
    end
  end