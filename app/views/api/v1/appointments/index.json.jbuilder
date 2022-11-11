# frozen_string_literal: true

json.array! @appointments, partial: 'api/v1/appointments/appointment', as: :appointment
