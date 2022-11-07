json.extract! document, :id, :state, :name, :description, :tax_income_id, :requested_by_id, :requested_to_id, :created_at, :updated_at
json.url api_v1_document_url(document, format: :json)
json.attachments document.data do |attachment|
    json.filename attachment.filename
    json.id attachment.id
    json.url url_for(attachment)
end
