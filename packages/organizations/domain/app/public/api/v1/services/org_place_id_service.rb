class Api::V1::Services::OrgPlaceIdService < ApplicationService
  def call(organization_id)
    organization = Api::V1::Organization.find(organization_id)

    if organization.google_place_id.present? && organization.google_place_verified
      return organization
    end

    if organization.address.present? && !Rails.env.test?
      organization.update!(google_place_id: place_id)
    end

    organization
  end

  def place_id
    GooglePlaces::Client.new(ENV.fetch('GOOGLE_API_KEY', nil)).spots_by_query(organization.address_with_name).first.place_id
  end
end
