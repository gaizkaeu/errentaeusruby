# frozen_string_literal: true

class Api::V1::OrganizationRequestPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def show?
    user.admin?
  end

  def index?
    show?
  end
end
