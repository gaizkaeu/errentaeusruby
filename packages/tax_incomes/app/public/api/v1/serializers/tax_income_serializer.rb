class Api::V1::Serializers::TaxIncomeSerializer
  include JSONAPI::Serializer

  set_type :tax_income
  attributes :year, :observations

  belongs_to :client, record_type: :user, serializer: Api::V1::Serializers::UserSerializer
  belongs_to :lawyer, record_type: :user, serializer: Api::V1::Serializers::UserSerializer
  belongs_to :appointment, record_type: :appointment
  belongs_to :estimation, record_type: :estimation
end
