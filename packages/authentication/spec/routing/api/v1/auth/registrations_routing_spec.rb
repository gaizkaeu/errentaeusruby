require 'rails_helper'

# rubocop:disable RSpec/ExpectActual
RSpec.describe Api::V1::Auth::RegistrationsController do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/api/v1/auth/sign_up').to route_to('api/v1/auth/registrations#create', format: 'json')
    end
  end
end

# rubocop:enable RSpec/ExpectActual
