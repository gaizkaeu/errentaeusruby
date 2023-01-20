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
    organization
  end

  factory :tax_income_with_lawyer, class: 'Api::V1::TaxIncome' do
    client
    association :lawyer, factory: :lawyer_profile
    organization
    state { 'meeting' }
  end

  factory :organization, class: 'Api::V1::OrganizationRecord' do
    name { 'My Excellent Organization' }
    phone { '1234567890' }
    email { 'gasdasd@gmail.com' }
    website { 'https://www.google.com' }
    description { 'My Excellent Organization' }
    prices do
      { prueba: 'asd' }
    end
    association :owner, factory: :lawyer
  end

  factory :lawyer_profile, class: 'Api::V1::LawyerProfileRecord' do
    association :user, factory: :lawyer
    organization
    org_status { 'pending' }
  end

  factory :appointment, class: 'Api::V1::AppointmentRecord' do
    association :tax_income, factory: :tax_income_with_lawyer
    client
    association :lawyer, factory: :lawyer_profile
    time { '2025-11-30T11:30:00.000Z' }
    meeting_method { 'office' }
  end

  factory :account_history, class: 'Account::AuthenticationAuditLog' do
    account
    message { 'log_in' }
    at { '2025-11-3time0T11:30:00.000Z' }
    metadata { { ip: '0.0.0.0' } }
  end
end
