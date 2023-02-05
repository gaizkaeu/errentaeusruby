# frozen_string_literal: true

class Api::V1::PayoutPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def index?
    user.org_manage? || user.admin?
  end

  def forced_filter_params
    case user.account_type
    when 'org_manage'
      org = Api::V1::Repositories::OrganizationRepository.where(owner_id: user.id).first
      { organization_id: org.id }
    end
  end
end
