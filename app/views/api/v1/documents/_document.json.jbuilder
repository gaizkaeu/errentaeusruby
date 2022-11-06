json.extract! document, :id, :state, :name, :description, :tax_income_id, :data, :created_at, :updated_at
json.url api_v1_document_url(document, format: :json)
json.data url_for(document.data)
