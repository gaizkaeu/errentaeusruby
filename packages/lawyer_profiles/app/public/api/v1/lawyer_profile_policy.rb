# frozen_string_literal: true

class Api::V1::LawyerProfilePolicy < ApplicationPolicy
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

  def destroy?
    update?
  end
end
