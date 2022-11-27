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
        false
      end

      def show?
        user.lawyer?
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
          return unless user.lawyer?
            scope
          
        end

        private

        attr_reader :user, :scope
      end
    end
  end
end
