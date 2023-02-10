# frozen_string_literal: true

class Api::V1::TransactionPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def index?
    true
  end

  def forced_filter_params
    case user.account_type
    when 'client', 'lawyer', 'org_manage'
      { user_id: user.id }
    end
  end
end
