FactoryBot.define do
  factory :organization, class: 'Api::V1::Organization' do
    name { Faker::Company.name[0, 30] }
    phone { Faker::Number.number(digits: 10) }
    email { Faker::Internet.email }
    website { Faker::Internet.url }
    description { Faker::Lorem.paragraph }

    open_close_hours {
      {
        monday: {
          open: '09:00',
          close: '17:00'
        },
        tuesday: {
          open: '09:00',
          close: '17:00'
        },
        wednesday: {
          open: '09:00',
          close: '17:00'
        },
        thursday: {
          open: '09:00',
          close: '17:00'
        },
        friday: {
          open: '09:00',
          close: '17:00'
        },
        saturday: {
          open: '09:00',
          close: '17:00'
        },
        sunday: {
          open: '09:00',
          close: '17:00'
        }
      }
    }

    # Define a trait to create memberships for the organization
    trait :with_memberships do
      transient do
        memberships_count { 2 }
      end

      after(:create) do |organization, evaluator|
        create_list(:organization_membership, evaluator.memberships_count, organization:)
      end
    end
  end

  factory :organization_membership, class: 'Api::V1::OrganizationMembership' do
    association :user, factory: :user
    association :organization, factory: :organization
    role { 'admin' }

    trait :admin do
      role { 'admin' }
    end

    trait :lawyer do
      role { 'lawyer' }
    end
  end
end
