# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
class TaxIncomeMailer < ApplicationMailer
  def creation(tax_income_id)
    @tax_income = Api::V1::TaxIncomeRepository.find(tax_income_id)
    user = Api::V1::UserRepository.find(@tax_income.client_id)

    attachments.inline['img1'] = Rails.public_path.join('tax_income_mailer', 'check-icon.png').read
    attachments.inline['img2'] = Rails.public_path.join('android-chrome-192x192.png').read
    mail(to: user.email, subject: '✅ Creación de tu declaración de la renta.')
  end
end
# rubocop:enable Metrics/AbcSize
