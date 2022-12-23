# frozen_string_literal: true

module Api
  module V1
    class AppointmentPolicy < ApplicationPolicy
      attr_reader :user, :record

      def initialize(user, record)
        @user = user
        @record = record
        super
      end

      def index?
        record.client_id == user.id || user.lawyer?
      end

      def show?
        index?
      end

      def create?
        index?
      end

      def update?
        index?
      end

      def destroy?
        false
      end
    end
  end
end
