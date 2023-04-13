module Api::V1::Concerns::Geocodable
  extend ActiveSupport::Concern

  included do
    geocoded_by :address
    reverse_geocoded_by :latitude, :longitude
    after_validation :geocode unless Rails.env.test?

    scope :coordinates, ->(coords) { near(coords.split(',')) }
    scope :bounds, ->(bounds) { within_bounding_box(bounds.split(',')) }
    scope :near_by, ->(loc) { near(loc) }
  end

  def address
    [street, postal_code, city, province, country].compact.join(', ')
  end

  def address_with_name
    [name, address].compact.join(', ')
  end

  # Google Places details

  def google_place_details
    return {} if google_place_id.blank? || !google_place_verified

    Rails.cache.fetch("google_place_details_#{google_place_id}", expires_in: 1.day) do
      GooglePlaces::Client.new(ENV.fetch('GOOGLE_API_KEY', nil)).spot(google_place_id, fields: 'reviews,rating', language: 'es').json_result_object
    end
  end
end
