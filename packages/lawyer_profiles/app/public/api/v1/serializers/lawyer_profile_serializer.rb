class Api::V1::Serializers::LawyerProfileSerializer
  include JSONAPI::Serializer

  set_type :lawyer_profile
  set_id :id

  attributes :first_name, :last_name, :avatar_url

  attributes :lawyer_status,
             if: proc { |_record, params|
                   (params[:manage].present? && params[:manage] == true) ||
                     (params[:org_admin].present? && params[:org_admin] == true)
                 }

  belongs_to :user, record_type: :user, serializer: Api::V1::Serializers::UserSerializer
  belongs_to :organization, record_type: :organization, serializer: Api::V1::Serializers::OrganizationSerializer, if: proc { |record, params| (params[:manage].present? && params[:manage] == true) || record.org_status == 'accepted' }
end
