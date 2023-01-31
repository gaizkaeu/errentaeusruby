# frozen_string_literal: true

class Api::V1::OrganizationPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def permitted_filter_params_manage
    case user.account_type
    when 'admin' || 'org_manage'
      %i[coordinates location_name name price_range featured owner_id]
    else
      %i[]
    end
  end

  def filter_forced_params_manage
    case user.account_type
    when 'org_manage'
      { owner_id: user.id }
    else
      {}
    end
  end

  def show?
    if record.status == 'not_subscribed'
      (user.account_type == 'org_manage' && record.owner_id == user.id) || user.admin?
    else
      true
    end
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

  def manage_index?
    user.account_type == 'org_manage' || user.admin?
  end
end
