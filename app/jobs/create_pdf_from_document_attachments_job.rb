# frozen_string_literal: true

class CreatePdfFromDocumentAttachmentsJob < ApplicationJob
  queue_as :default

  def perform(document)
    # save PDF to disk
    pdf_path = Rails.root.join('tmp', "#{document.id}.pdf")
    File.open(pdf_path, 'wb') do |file|
      file << generate_pdf(document)
    end

    document.exported_document.attach(io: File.open(pdf_path), filename: '1.pdf')
    document.export_done!
  end

  def generate_pdf(document)
    WickedPdf.new.pdf_from_string(
      ApplicationController.render(
        template: 'api/v1/documents/pdf_export',
        locals: { doc: document }
      ),
      show_as_html: true,
      page_size: 'Letter',
      margin: { top: 5, bottom: 5, left: 5, right: 5 }
    )
  end
end
