class Api::V1::Serializers::OrganizationSerializer
  include JSONAPI::Serializer

  set_type :organization
  set_id :id
  attributes :name, :description, :website, :email, :phone, :prices, :logo, :created_at, :price_range, :tax_income_count, :ratings, :status
  attributes :latitude, :longitude, :city, :province, :country, :street, :postal_code

  belongs_to :owner, record_type: :user, serializer: Api::V1::Serializers::UserSerializer
end
