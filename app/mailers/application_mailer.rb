# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'ERRENTA.EUS <gestion@elizaasesores.com>', reply_to: 'ERRENTA.EUS <contacto@elizaasesores.com>'
  layout 'mailer'
end
