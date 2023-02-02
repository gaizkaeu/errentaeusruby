# frozen_string_literal: true

class Api::V1::UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def permitted_attributes_update
    case user.account_type
    when 'admin'
      %i[account_type]
    else
      %i[first_name last_name]
    end
  end

  def index?
    user.admin?
  end

  def block?
    user.admin?
  end

  def show?
    user.admin? || record.id == user.id
  end

  def access_history?
    show?
  end

  def resend_confirmation?
    record == user
  end

  def create?
    false
  end

  def update?
    show?
  end

  def destroy?
    false
  end
end
