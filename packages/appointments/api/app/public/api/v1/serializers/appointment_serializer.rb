class Api::V1::Serializers::AppointmentSerializer
  include JSONAPI::Serializer

  set_type :appointment
  attributes :time, :meeting_method, :organization_id, :user_id, :organization_membership_id

  attribute :phone,
            if: proc { |record|
                  record.meeting_method == 'phone'
                }

  attribute :lawyer_profile,
            if: proc { |record, params|
                  record.organization_membership_id.present? && params.present? && params[:include_lawyer_profile]
                } do |record|
    Api::V1::Serializers::LawyerProfileSerializer.new(record.lawyer_profile) if record.lawyer_profile.present?
  end

  attribute :user,
            if: proc { |_record, params|
                  params.present? && params[:include_user]
                } do |record|
    Api::V1::Serializers::UserSerializer.new(record.user) if record.user.present?
  end
end
