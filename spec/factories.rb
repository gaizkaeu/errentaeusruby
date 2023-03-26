FactoryBot.define do
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

  factory :tax_income_with_lawyer, class: 'Api::V1::TaxIncome' do
    client
    association :lawyer, factory: :lawyer_profile
    organization
    state { 'meeting' }
  end

  factory :organization_stat, class: 'Api::V1::OrganizationStatRecord' do
    organization
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
