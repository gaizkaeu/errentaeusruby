# frozen_string_literal: true

class Api::V1::AppointmentPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    super
  end
end
