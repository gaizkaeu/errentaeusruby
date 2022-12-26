# frozen_string_literal: true

class AppointmentCreationJob < ApplicationJob
  def perform(params)
    AppointmentMailer.creation(params['appointment_id'], :client).deliver_now!
    AppointmentMailer.creation(params['appointment_id'], :lawyer).deliver_now!
  end
end
