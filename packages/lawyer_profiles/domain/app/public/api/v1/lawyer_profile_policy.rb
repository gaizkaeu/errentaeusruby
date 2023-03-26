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
    index?
  end

  def update?
    record.user_id == user.id
  end

  def delete?
    update?
  end
end
