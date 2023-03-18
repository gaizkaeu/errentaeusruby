# frozen_string_literal: true

class Api::V1::OrganizationPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def forced_create_params
    case user.account_type
    when 'org_manage'
      { owner_id: user.id }
    else
      {}
    end
  end

  def permitted_filter_params_manage
    case user.account_type
    when 'admin', 'org_manage'
      %i[coordinates location_name name price_range featured owner_id]
    else
      %i[]
    end
  end

  def show?
    if record.visible == false
      record.user_part_of_organization?(user.id) || user.admin?
    else
      true
    end
  end

  def create?
    true
  end

  def update?
    record.user_is_admin?(user.id) || user.admin?
  end

  def manage?
    update?
  end

  def destroy?
    update?
  end

  def manage_subscription?
    update?
  end
end
