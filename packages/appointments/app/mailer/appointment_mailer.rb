# frozen_string_literal: true

class AppointmentMailer < ApplicationMailer
  def creation(appointment_id)
    @appointment = Api::V1::AppointmentRepository.find(appointment_id)
    @notify_to = Api::V1::UserRepository.find(@appointment.client_id)
    @appointment_with = Api::V1::UserRepository.find(@appointment.lawyer_id)

    mail(to: @notify_to.email, subject: 'Confirmación de cita.')

    @notify_to, @appointment_with = @appointment_with, @notify_to

    mail(to: @notify_to.email, subject: 'Confirmación de cita.')
  end
end
