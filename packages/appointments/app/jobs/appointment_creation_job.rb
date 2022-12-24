# frozen_string_literal: true

class AppointmentCreationJob < ApplicationJob
  def perform(params)
    AppointmentMailer.creation(params['appointment_id']).deliver_now!
  end
end
