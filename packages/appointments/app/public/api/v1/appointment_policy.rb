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
        true
      end

      def show?
        if record.client_id == user.id
          true
        else
          Api::V1::Repositories::LawyerProfileRepository.find_by!(user_id: user.id).id == record.lawyer_id
        end
      rescue ActiveRecord::RecordNotFound
        false
      end

      def create?
        index?
      end

      def update?
        show?
      end

      def destroy?
        false
      end
    end
  end
end
