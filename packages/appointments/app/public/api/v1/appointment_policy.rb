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
          if user.lawyer?
            scope.joins(:tax_income).where(tax_incomes: { lawyer_id: user.id })
          else
            scope.joins(:tax_income).where(tax_incomes: { client_id: user.id })
          end
        end

        private

        attr_reader :user, :scope
      end
    end
  end
end
