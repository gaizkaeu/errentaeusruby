class Api::V1::Serializers::AppointmentSerializer
  include JSONAPI::Serializer

  set_type :tax_income
  attributes :time, :meeting_method

  belongs_to :client, record_type: :user
  belongs_to :lawyer, record_type: :user
end
