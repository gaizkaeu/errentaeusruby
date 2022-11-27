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

      def permitted_attributes
        if user.lawyer?
          [:user_id, :observations, :price, :lawyer_id, :id, :state]
        else
          [:observations]
        end
      end

      def index?
        record.client == user || record.lawyer = user
      end

      def show?
        index?
      end

      def create?
        record.client == user || user.lawyer?
      end

      def update?
        create?
      end

      def destroy?
        false
      end

      def checkout?
        record.client == user
      end

      class Scope
        def initialize(user, scope)
          @user = user
          @scope = scope
        end

        def resolve
          if user.lawyer?
            scope.where(lawyer: user)
          else
            scope.where(client: user)
          end
        end

        private

        attr_reader :user, :scope
      end
    end
  end
end
