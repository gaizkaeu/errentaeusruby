# frozen_string_literal: true

class Api::V1::ReviewPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def create?
    true
  end

  def serializer_config
    case user.account_type
    when 'org_manage'
      { params: { manage: true } }
    else
      {}
    end
  end
end
