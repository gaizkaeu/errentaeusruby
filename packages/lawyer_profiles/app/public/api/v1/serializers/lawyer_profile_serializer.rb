class Api::V1::Serializers::LawyerProfileSerializer
  include JSONAPI::Serializer

  set_type :lawprof
  set_id :id

  attributes :org_status,
             :lawyer_status,
             if: proc { |_record, params|
                   params[:manage].present? && params[:manage] == true
                 }

  belongs_to :user, record_type: :user, serializer: Api::V1::Serializers::UserSerializer
  belongs_to :organization, record_type: :organization, serializer: Api::V1::Serializers::OrganizationSerializer
end
