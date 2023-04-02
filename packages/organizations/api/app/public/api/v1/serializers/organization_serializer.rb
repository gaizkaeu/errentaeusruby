class Api::V1::Serializers::OrganizationSerializer
  include JSONAPI::Serializer

  set_type :organization
  set_id :id
  attributes :name, :description, :website, :email, :phone, :prices, :created_at, :price_range, :tax_income_count, :status
  attributes :latitude, :longitude, :city, :province, :country, :street, :postal_code

  attributes :app_fee,
             :subscription_id,
             :settings,
             :google_place_id,
             :google_place_verified,
             :google_place_details,
             if: proc { |_record, params|
                   params[:manage].present? && params[:manage] == true
                 }

  attribute :skill_list, &:skill_list_name
  attribute :google_place_details, if: proc { |rec| rec.google_place_id.present? && rec.google_place_verified }

  attributes :ratings do |object|
    {
      average: object.avg_rating,
      one_star_count: object.one_star_count,
      two_star_count: object.two_star_count,
      three_star_count: object.three_star_count,
      four_star_count: object.four_star_count,
      five_star_count: object.five_star_count
    }
  end

  attributes :visible
end
