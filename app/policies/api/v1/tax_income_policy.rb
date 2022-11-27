# frozen_string_literal: true
module Api
  module V1
    class TaxIncomePolicy < ApplicationPolicy
      attr_reader :user, :record

      def initialize(user, record)
        @user = user
        @record = record
        super
      end

      def index?
        record.user = user || record.lawyer = user
      end

      def show?
        index?
      end

      def create?
        record.user = user || user.account_type = "lawyer"
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
          if user.account_type == "lawyer"
            scope.where(lawyer: user)
          else
            scope.where(user:)
          end
        end

        private

        attr_reader :user, :scope
      end
    end
  end
end
