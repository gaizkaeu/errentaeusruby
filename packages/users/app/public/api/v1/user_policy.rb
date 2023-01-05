# frozen_string_literal: true

module Api
  module V1
    class UserPolicy < ApplicationPolicy
      attr_reader :user, :record

      def initialize(user, record)
        @user = user
        @record = record
        super
      end

      def permitted_attributes_update
        %i[first_name last_name]
      end

      def index?
        user.lawyer?
      end

      def block?
        user.lawyer?
      end

      def show?
        user.lawyer? || record.id == user.id
      end

      def access_history?
        show?
      end

      def resend_confirmation?
        record == user
      end

      def create?
        false
      end

      def update?
        show?
      end

      def destroy?
        false
      end

      class Scope
        def initialize(user, scope)
          @user = user
          @scope = scope
        end

        def resolve
          raise Pundit::NotAuthorizedError unless user.lawyer?

          scope.all
        end

        private

        attr_reader :user, :scope
      end
    end
  end
end
