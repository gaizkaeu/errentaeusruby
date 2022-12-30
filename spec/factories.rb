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

  factory :user, class: 'Api::V1::UserRecord', aliases: [:client] do
    first_name { 'My Excellent' }
    last_name  { 'Lawyer' }
    phone { '1234567890' }
    account
  end

  factory :blocked_user, class: 'Api::V1::UserRecord' do
    first_name { 'My Excellent' }
    last_name  { 'Lawyer' }
    account
  end

  factory :unconfirmed_user, class: 'Api::V1::UserRecord' do
    first_name { 'My Excellent' }
    last_name  { 'Lawyer' }
    phone { '1234567890' }
    account
  end

  factory :lawyer, class: 'Api::V1::UserRecord' do
    first_name { 'Carolina' }
    last_name  { 'Doe' }
    phone { '1234567890' }
    account_type { 'lawyer' }
    account
  end

  factory :tax_income, class: 'Api::V1::TaxIncome' do
    client
  end

  factory :tax_income_with_lawyer, class: 'Api::V1::TaxIncome' do
    client
    lawyer
    state { 'meeting' }
  end

  factory :appointment, class: 'Api::V1::AppointmentRecord' do
    association :tax_income, factory: :tax_income_with_lawyer
    client
    lawyer
    time { '2025-11-30T11:30:00.000Z' }
    meeting_method { 'office' }
  end

  factory :account_history, class: 'Api::V1::AccountHistoryRecord' do
    user
    action { 'log_in' }
    ip { '0.0.0.0' }
    time { '2025-11-30T11:30:00.000Z' }
  end
end
