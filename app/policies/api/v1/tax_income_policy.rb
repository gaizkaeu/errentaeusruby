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
          [:client_id, :observations, :price, :lawyer_id, :id, :state, :year]
        else
          [:observations, :year]
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

      def documents?
        index?
      end

      def payment_data?
        index?
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
