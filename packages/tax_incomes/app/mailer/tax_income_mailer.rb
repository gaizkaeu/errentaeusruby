# frozen_string_literal: true

class TaxIncomeMailer < ApplicationMailer
  def creation(tax_income_id)
    @tax_income = Api::V1::TaxIncome.find(tax_income_id)

    attachments.inline['img1'] = File.read('./public/tax_income_mailer/check-icon.png')
    attachments.inline['img2'] = File.read('./public/android-chrome-192x192.png')
    mail(to: @tax_income.client.email, subject: '✅ Creación de tu declaración de la renta.')
  end
end
