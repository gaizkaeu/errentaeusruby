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
          record.client_id == user.id
        elsif user.lawyer?
          record.lawyer_id == user.id
        end
      end

      def create?
        if user.client?
          record.client_id == user.id
        elsif user.lawyer?
          record.lawyer_id == user.id
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
        record.client_id == user.id || record.lawyer_id = user.id
      end

      def checkout?
        record.client_id == user_id
      end
    end
  end
end
