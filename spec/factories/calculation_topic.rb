FactoryBot.define do
  factory :calculation_topic, class: 'Api::V1::CalculationTopic' do
    description { Faker::Lorem.sentence }

    trait :calct_test_schema do
      name { 'Puesta en marcha de empresas' }
      validation_file { 'calct_test_schema.json' }
      prediction_attributes do
        {
          constitucion: {
            name: 'constitucion',
            type: 'string',
            question: {
              title: 'Escoge el tipo de constitucion',
              field_type: 'select_unique',
              options: %w[sociedad autonomo]
            }
          },
          trabajadores: {
            name: 'trabajadores',
            type: 'integer',
            question: {
              title: 'Trabajadores',
              field_type: 'input'
            }
          },
          impuestos_especiales: {
            name: 'impuestos_especiales',
            type: 'boolean',
            question: {
              title: 'Impuestos especiales',
              field_type: 'boolean'
            }
          }
        }
      end
    end
  end
end
