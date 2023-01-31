# frozen_string_literal: true

class Api::V1::OrganizationPolicy < ApplicationPolicy
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
    index?
  end

  def create?
    user.lawyer?
  end

  def review?
    true
  end

  def update?
    record.owner_id == user.id
  end

  def manage_index?
    user.account_type == 'org_manage' || user.admin?
  end

  def manage_subscription?
    update?
  end

  def manage?
    update?
  end

  def accept?
    update?
  end

  def reject?
    update?
  end

  def destroy?
    update?
  end
end
