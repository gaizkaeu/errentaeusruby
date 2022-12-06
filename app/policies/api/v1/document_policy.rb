# frozen_string_literal: true
module Api
  module V1
    class DocumentPolicy < ApplicationPolicy
      attr_reader :user, :record

      def initialize(user, record)
        @user = user
        @record = record
        super
      end
      
      def history?
        show?
      end

      def add_document_attachment?
        show?
      end

      def delete_document_attachment?
        show?
      end

      def show?
        record.tax_income.client == user || record.tax_income.lawyer == user
      end

      def create?
        user.lawyer?
      end

      def update?
        create?
      end

      def destroy?
        create?
      end

      def export_document?
        create?
      end

      class Scope
        def initialize(user, scope)
          @user = user
          @scope = scope
        end

        def resolve
          if user.lawyer?
            scope.join(:tax_incomes).includes(:lawyer).where(lawyer: user)
          else
            scope.join(:tax_incomes).includes(:user).where(client: user)
          end
        end

        private

        attr_reader :user, :scope
      end
    end
  end
end
