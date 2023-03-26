# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def index_webauthn_keys?
    user.lawyer? || user.account_id == record.id
  end

  def index?
    user.lawyer?
  end

  def show?
    user.lawyer? || record.id == user.id
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
