# frozen_string_literal: true

class AppointmentMailer < ApplicationMailer
  def creation(appointment_id, notify_to)
    @appointment = Api::V1::Repositories::AppointmentRepository.find(appointment_id)

    case notify_to
    when :client
      @notify_to = Api::V1::Repositories::UserRepository.find(@appointment.client_id)
      @appointment_with = Api::V1::Repositories::UserRepository.find(@appointment.lawyer_id)
    when :lawyer
      @notify_to = Api::V1::Repositories::UserRepository.find(@appointment.lawyer_id)
      @appointment_with = Api::V1::Repositories::UserRepository.find(@appointment.client_id)
    end

    mail(to: @notify_to.email, subject: 'Confirmación de cita.')
  end

  def update(appointment_id, notify_to)
    @appointment = Api::V1::Repositories::AppointmentRepository.find(appointment_id)

    case notify_to
    when :client
      @notify_to = Api::V1::Repositories::UserRepository.find(@appointment.client_id)
      @appointment_with = Api::V1::Repositories::UserRepository.find(@appointment.lawyer_id)
    when :lawyer
      @notify_to = Api::V1::Repositories::UserRepository.find(@appointment.lawyer_id)
      @appointment_with = Api::V1::Repositories::UserRepository.find(@appointment.client_id)
    end

    mail(to: @notify_to.email, subject: 'Actualización de cita.')
  end
end
