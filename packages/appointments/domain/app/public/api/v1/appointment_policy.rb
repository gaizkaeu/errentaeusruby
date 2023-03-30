# frozen_string_literal: true

class Api::V1::AppointmentPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user || user.admin? || record.organization.user_is_member?(user.id)
  end

  def destroy?
    update?
  end
end
