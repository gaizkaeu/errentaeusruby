class Api::V1::Serializers::AppointmentSerializer
  include JSONAPI::Serializer

  set_type :tax_income
  attributes :time, :meeting_method

  attribute :phone,
            if: proc { |record|
                  record.meeting_method == 'phone'
                }
end
