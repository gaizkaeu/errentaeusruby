class Api::V1::Serializers::AppointmentSerializer
  include JSONAPI::Serializer

  set_type :appointment
  attributes :time, :meeting_method, :organization_id, :user_id

  attribute :phone,
            if: proc { |record|
                  record.meeting_method == 'phone'
                }
end
