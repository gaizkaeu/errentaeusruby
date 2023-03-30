# frozen_string_literal: true

class AppointmentUpdateJob < ApplicationJob
  def perform(params)
    AppointmentMailer.update(params['appointment_id'], :client).deliver_now!
    AppointmentMailer.update(params['appointment_id'], :lawyer).deliver_now!
  end
end
