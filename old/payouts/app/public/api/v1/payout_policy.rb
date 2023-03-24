# frozen_string_literal: true

class Api::V1::PayoutPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def index?
    user.admin?
  end
end
