FactoryBot.define do
  factory :calculator, class: 'Api::V1::Calculator' do
    association :organization, factory: :organization
    # Define a trait to create memberships for the organization
    trait :calct_test_schema do
      association :calculation_topic, :calct_test_schema
      marshalled_predictor { 'asdasd' }

      classifications do
        {
          simple1: '25*TRABAJADORES',
          simple2: '30*TRABAJADORES',
          complejo1: '25*TRABAJADORES+1000',
          complejo2: '30*TRABAJADORES+1000'
        }
      end
    end
  end
end
