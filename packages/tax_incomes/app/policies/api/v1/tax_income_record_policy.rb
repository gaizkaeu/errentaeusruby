# frozen_string_literal: true

module Api
  module V1
    class TaxIncomeRecordPolicy < ApplicationPolicy
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
          record.client.id == user.id
        elsif user.lawyer?
          record.lawyer.id == user.id
        else
          false
        end
      end

      def create?
        if user.client?
          record.client.id == user.id
        elsif user.lawyer?
          record.lawyer.id == user.id
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
        record.client.id == user.id || record.lawyer.id = user.id
      end

      def checkout?
        record.client.id == user.id
      end

      class Scope
        def initialize(user, scope)
          @user = user
          @scope = scope
        end

        def resolve
          if user.lawyer?
            scope.where(lawyer_id: user.id).includes(:client, :lawyer)
          else
            scope.where(client_id: user.id).includes(:client, :lawyer)
          end
        end

        private

        attr_reader :user, :scope
      end
    end
  end
end
