require 'rails_helper'

RSpec.describe Api::V1::MyLawyerProfileController do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/api/v1/my-lawyer-profile').to route_to('api/v1/my_lawyer_profile#show', format: 'json')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/my-lawyer-profile').to route_to('api/v1/my_lawyer_profile#create', format: 'json')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/my-lawyer-profile').to route_to('api/v1/my_lawyer_profile#update', format: 'json')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/my-lawyer-profile').to route_to('api/v1/my_lawyer_profile#destroy', format: 'json')
    end
  end
end
