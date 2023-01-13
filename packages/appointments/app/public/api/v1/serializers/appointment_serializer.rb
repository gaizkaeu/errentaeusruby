class Api::V1::Serializers::AppointmentSerializer
  include JSONAPI::Serializer

  set_type :tax_income
  attributes :time, :meeting_method

  attribute :phone,
            if: proc { |record|
                  record.meeting_method == 'phone'
                }

  belongs_to :client, record_type: :user, serializer: Api::V1::Serializers::UserSerializer
  belongs_to :lawyer, record_type: :user, serializer: Api::V1::Serializers::UserSerializer
  belongs_to :tax_income, record_type: :tax_income, serializer: Api::V1::Serializers::TaxIncomeSerializer
end
