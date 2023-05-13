FactoryBot.define do
  factory :calculation, class: 'Api::V1::Calculation' do
    association :user, factory: :user
    # Define a trait to create memberships for the organization
    trait :calct_test_schema do
      association :calculation_topic, :calct_test_schema
      association :calculator, :calct_test_schema

      input do
        {
          constitucion: %w[sociedad autonomo].sample(1).first,
          trabajadores: Faker::Number.between(from: 1, to: 10),
          impuestos_especiales: [true, false].sample(1).first
        }
      end
    end
  end
end
