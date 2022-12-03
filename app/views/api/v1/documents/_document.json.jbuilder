# frozen_string_literal: true

json.extract! document, :id, :state, :name, :tax_income_id, :export_status, :document_number,
              :created_at, :updated_at
json.url api_v1_document_url(document, format: :json)
json.attachments document.files do |attachment|
  json.filename attachment.filename
  json.id attachment.id
  json.url url_for(attachment)
end
if document.export_status == 'export_successful'
  json.export do
    json.filename document.exported_document.filename
    json.id document.exported_document.id
    json.url url_for(document.exported_document)
  end
end
