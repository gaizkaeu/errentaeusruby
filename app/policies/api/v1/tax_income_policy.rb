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
          %i[client_id observations price lawyer_id id state year]
        else
          %i[observations year]
        end
      end

      def show?
        if user.client?
          record.client == user
        elsif user.lawyer?
          record.lawyer == user
        else
          false
        end
      end

      def create?
        if user.client?
          record.client == user
        elsif user.lawyer?
          record.lawyer == user
        end
      end

      def documents?
        create?
      end

      def payment_data?
        create?
      end

      def update?
        create?
      end

      def destroy?
        record.client == user || record.lawyer = user
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
            scope.where(lawyer: user).includes(:client, :lawyer)
          else
            scope.where(client: user).includes(:client, :lawyer)
          end
        end

        private

        attr_reader :user, :scope
      end
    end
  end
end
