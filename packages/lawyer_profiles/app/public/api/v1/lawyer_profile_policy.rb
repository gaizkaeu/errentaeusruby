# frozen_string_literal: true

class Api::V1::LawyerProfilePolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def permitted_attributes_update
    case user.account_type
    when 'lawyer'
      %i[avatar]
    when 'org_manage'
      %i[lawyer_status org_status]
    else
      []
    end
  end

  def serializer_config
    case user.account_type
    when 'org_manage' || 'admin'
      { params: { manage: true } }
    else
      {}
    end
  end

  def index?
    user.org_manage?
  end

  def show?
    true
  end

  def create?
    user.lawyer?
  end

  def me?
    create?
  end

  def update?
    if record.user_id == user.id
      true
    else
      (record.organization_id.present? && Api::V1::Repositories::OrganizationRepository.find(record.organization_id).owner_id == user.id) || user.admin?
    end
  end

  def delete?
    update?
  end
end
