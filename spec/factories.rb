FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user, class: 'Api::V1::User', aliases: [:client] do
    first_name { 'My Excellent' }
    last_name  { 'Lawyer' }
    email { generate(:email) }
    password { 'test123' }
    password_confirmation { 'test123' }
    confirmed_at { '04-07-2002' }
    uid { email }
  end

  factory :unconfirmed_user, class: 'Api::V1::User' do
    first_name { 'My Excellent' }
    last_name  { 'Lawyer' }
    email { generate(:email) }
    password { 'test123' }
    password_confirmation { 'test123' }
    uid { email }
  end

  factory :lawyer, class: 'Api::V1::User' do
    first_name { 'Carolina' }
    last_name  { 'Doe' }
    email { generate(:email) }
    password { 'test123' }
    password_confirmation { 'test123' }
    confirmed_at { '04-07-2002' }
    uid { email }
    account_type { 'lawyer' }
  end

  factory :tax_income, class: 'Api::V1::TaxIncome' do
    client
  end

  factory :appointment, class: 'Api::V1::Appointment' do
    tax_income
    time { ' Wed, 21 Dec 2025 11:30:00.000000000 UTC +00:00' }
    meeting_method { 'phone' }
  end
end
