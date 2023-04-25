class Api::V1::Serializers::EmailSerializer
  include JSONAPI::Serializer

  set_type :call
  set_id :id
  attributes :first_name, :last_name, :organization_id, :user_id, :created_at

  attributes :email,
             if: proc { |_record, params|
                   params[:manage].present? && params[:manage] == true
                 }
end
