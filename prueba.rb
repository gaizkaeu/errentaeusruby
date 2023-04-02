require 'google_places'

# Set up the API endpoint and parameters
api_key = 'AIzaSyAVJ4unu6x9VcFQHkyxHv_3DQyaR4zIuic'
place_id = 'ChIJAX9LdnrCTw0RsoODh2KDkY0'

@client = GooglePlaces::Client.new(api_key)
@client.spot(place_id)

puts @client.spot(place_id).inspect
