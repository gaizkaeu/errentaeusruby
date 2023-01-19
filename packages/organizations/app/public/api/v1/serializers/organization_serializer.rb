class Api::V1::Serializers::OrganizationSerializer
  include JSONAPI::Serializer

  set_type :organization
  set_id :id
  attributes :name, :description, :website, :email, :phone, :location, :prices, :logo, :created_at, :price_range, :tax_income_count, :ratings, :featured

  belongs_to :owner, record_type: :user, serializer: Api::V1::Serializers::UserSerializer, if: proc { |_record, params| (params[:manage].present? && params[:manage] == true) }
end
