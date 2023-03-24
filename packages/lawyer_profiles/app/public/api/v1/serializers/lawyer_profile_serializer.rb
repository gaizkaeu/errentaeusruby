class Api::V1::Serializers::LawyerProfileSerializer
  include JSONAPI::Serializer

  set_type :lawyer_profile
  set_id :id

  attributes :first_name, :last_name, :avatar_url, :skills

  attributes :on_duty,
             if: proc { |_record, params|
                   (params[:manage].present? && params[:manage] == true) ||
                     (params[:org_admin].present? && params[:org_admin] == true)
                 }

  belongs_to :user, record_type: :user, serializer: Api::V1::Serializers::UserSerializer
end
