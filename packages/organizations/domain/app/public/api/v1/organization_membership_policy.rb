# frozen_string_literal: true

class Api::V1::OrganizationMembershipPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def own?
    record.user_id == user.id
  end
end
