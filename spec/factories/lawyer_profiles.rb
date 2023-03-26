FactoryBot.define do
  factory :lawyer_profile, class: 'Api::V1::LawyerProfile' do
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    user
  end
end
