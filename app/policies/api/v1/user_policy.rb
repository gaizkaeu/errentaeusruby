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

      def index?
        user.lawyer?
      end

      def show?
        user.lawyer?
      end

      def resend_confirmation?
        record == user
      end

      def create?
        false
      end

      def update?
        create?
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
          raise Pundit::Unauthorized unless user.lawyer?
            scope.all
          
            
          
        end

        private

        attr_reader :user, :scope
      end
    end
  end
end
