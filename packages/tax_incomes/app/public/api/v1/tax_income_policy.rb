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

      def permitted_attributes_create
        if user.lawyer?
          %i[client_id observations price lawyer_id id state year]
        else
          %i[observations year]
        end
      end

      def permitted_attributes_update
        if user.lawyer?
          %i[client_id observations price lawyer_id id state year]
        else
          %i[observations]
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

      def create_appointment?
        show?
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
        record.client_id == user.id
      end
    end
  end
end
