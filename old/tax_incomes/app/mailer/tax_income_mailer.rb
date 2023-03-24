# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
class TaxIncomeMailer < ApplicationMailer
  def creation(tax_income_id)
    @tax_income = Api::V1::Repositories::TaxIncomeRepository.find(tax_income_id)
    user = Api::V1::Repositories::UserRepository.find(@tax_income.client_id)

    attachments.inline['img1'] = Rails.public_path.join('tax_income_mailer', 'check-icon.png').read
    attachments.inline['img2'] = Rails.public_path.join('android-chrome-192x192.png').read
    mail(to: user.email, subject: '✅ Creación de tu declaración de la renta.')
  end

  def lawyer_assignation_notification(tax_income_id, lawyer_id)
    @tax_income = Api::V1::Repositories::TaxIncomeRepository.find(tax_income_id)
    user = Api::V1::Repositories::UserRepository.find(lawyer_id)

    mail(to: user.email, subject: 'Nueva asignación de declaración de la renta.')
  end

  def payment_succeeded_client(tax_income_id)
    @tax_income = Api::V1::Repositories::TaxIncomeRepository.find(tax_income_id)
    @dest = Api::V1::Repositories::UserRepository.find(@tax_income.client_id)

    mail(to: @dest.email, subject: 'Confirmación de pago.')
  end

  def payment_succeeded_lawyer(tax_income_id)
    @tax_income = Api::V1::Repositories::TaxIncomeRepository.find(tax_income_id)
    dest = Api::V1::Repositories::UserRepository.find(@tax_income.lawyer_id)
    @user = Api::V1::Repositories::UserRepository.find(@tax_income.client_id)

    mail(to: dest.email, subject: "Confirmación de pago (id: #{tax_income_id} - #{@user.first_name}).")
  end
end
# rubocop:enable Metrics/AbcSize
