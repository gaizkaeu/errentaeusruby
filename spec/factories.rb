FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user, class: 'Api::V1::UserRecord', aliases: [:client] do
    first_name { 'My Excellent' }
    last_name  { 'Lawyer' }
    email { generate(:email) }
    password { 'test123' }
    password_confirmation { 'test123' }
    confirmed_at { '04-07-2002' }
    uid { email }
    phone { '1234567890' }
  end

  factory :blocked_user, class: 'Api::V1::UserRecord' do
    first_name { 'My Excellent' }
    last_name  { 'Lawyer' }
    email { generate(:email) }
    password { 'test123' }
    password_confirmation { 'test123' }
    confirmed_at { '04-07-2002' }
    uid { email }
    phone { '1234567890' }
    blocked { true }
  end

  factory :unconfirmed_user, class: 'Api::V1::UserRecord' do
    first_name { 'My Excellent' }
    last_name  { 'Lawyer' }
    email { generate(:email) }
    password { 'test123' }
    phone { '1234567890' }
    password_confirmation { 'test123' }
    uid { email }
  end

  factory :lawyer, class: 'Api::V1::UserRecord' do
    first_name { 'Carolina' }
    last_name  { 'Doe' }
    email { generate(:email) }
    password { 'test123' }
    phone { '1234567890' }
    password_confirmation { 'test123' }
    confirmed_at { '04-07-2002' }
    uid { email }
    account_type { 'lawyer' }
  end

  factory :tax_income, class: 'Api::V1::TaxIncome' do
    client
  end

  factory :tax_income_with_lawyer, class: 'Api::V1::TaxIncome' do
    client
    lawyer
  end

  factory :appointment, class: 'Api::V1::AppointmentRecord' do
    tax_income
    client
    lawyer
    time { '2025-11-30T11:30:00.000Z' }
    meeting_method { 'phone' }
  end
end
