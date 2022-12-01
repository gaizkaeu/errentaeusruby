# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome_email(user_id)
    @user = Api::V1::User.find(user_id)

    attachments.inline["img1"] = File.read('./public/welcome_mail_assets/image-3.png')
    attachments.inline["img2"] = File.read('./public/android-chrome-192x192.png')
    mail(to: @user.email, subject: 'Bienvenido a ERRENTA.EUS! 🎉')
  end

  def prueba(user_id)
    @user = Api::V1::User.find(user_id)

    mail(to: @user.email, subject: 'Bienvenido a ERRENTA.EUS! 🎉')
  end
end
