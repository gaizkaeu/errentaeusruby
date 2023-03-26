FactoryBot.define do
  factory :review, class: 'Api::V1::Review' do
    comment { Faker::Lorem.sentence }
    rating { Faker::Number.between(from: 1, to: 5) }
    organization
    user
  end
end
