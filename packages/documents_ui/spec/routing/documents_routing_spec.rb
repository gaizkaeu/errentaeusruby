require 'rails_helper'

RSpec.describe Api::V1::DocumentsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/documents').to route_to('api/v1/documents#index', format: 'json')
    end

    it 'routes to #add_document_attachment' do
      expect(post: '/api/v1/documents/1/add_document_attachment').to route_to('api/v1/documents#add_document_attachment', id: '1', format: 'json')
    end

    it 'routes to #delete_document_attachment' do
      expect(delete: '/api/v1/documents/1/delete_document_attachment/1').to route_to('api/v1/documents#delete_document_attachment', id: '1', id_attachment: '1', format: 'json')
    end

    it 'routes to #export_document' do
      expect(post: '/api/v1/documents/1/export_document').to route_to('api/v1/documents#export_document', id: '1', format: 'json')
    end

    it 'routes to #document_history' do
      expect(get: '/api/v1/documents/1/history').to route_to('api/v1/documents#history', id: '1', format: 'json')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/documents/1').to route_to('api/v1/documents#show', id: '1', format: 'json')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/documents').to route_to('api/v1/documents#create', format: 'json')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/documents/1').to route_to('api/v1/documents#update', id: '1', format: 'json')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/v1/documents/1').to route_to('api/v1/documents#update', id: '1', format: 'json')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/documents/1').to route_to('api/v1/documents#destroy', id: '1', format: 'json')
    end
  end
end
