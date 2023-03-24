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

  factory :user, class: 'Api::V1::UserRecord' do
    first_name { 'My Excellent' }
    last_name  { 'Lawyer' }
    phone { '1234567890' }
    account
  end

  factory :review, class: 'Api::V1::ReviewRecord' do
    comment { 'My Excellent Review' }
    rating { 5 }
    organization
    user
  end

  factory :admin, class: 'Api::V1::UserRecord' do
    first_name { 'My Excellent' }
    last_name  { 'Lawyer' }
    phone { '1234567890' }
    account_type { 'admin' }
    account
  end

  factory :transaction, class: 'Api::V1::TransactionRecord' do
    amount { 100 }
    amount_capturable { 100 }
    status { 'succeeded' }
    payment_intent_id { 'pi_1Hq0Zo2eZvKYlo2C8Q2Z0Z2a' }
    user
    organization
  end

  factory :payout, class: 'Api::V1::PayoutRecord' do
    amount { 100 }
    status { 'pending' }
    date { '2025-11-30' }
    organization
  end

  factory :tax_income, class: 'Api::V1::TaxIncome' do
    client
    association :lawyer, factory: :lawyer_profile
    organization
  end

  factory :org_admin_membership, class: 'Api::V1::OrgMembershipRecord' do
    user
    organization
    role { 'admin' }
  end

  factory :org_lawyer_membership, class: 'Api::V1::OrgMembershipRecord' do
    user
    organization
    role { 'lawyer' }
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
  end

  factory :organization_stat, class: 'Api::V1::OrganizationStatRecord' do
    organization
  end

  factory :lawyer_profile, class: 'Api::V1::LawyerProfileRecord' do
    user
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
