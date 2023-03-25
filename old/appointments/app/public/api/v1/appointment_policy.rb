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

      def permitted_attributes_update
        case user.account_type
        when 'client', 'lawyer'
          %i[time meeting_method phone]
        when 'org_manage'
          %i[lawyer_id]
        else
          []
        end
      end

      def permitted_filter_params
        case user.account_type
        when 'client'
          %i[time]
        when 'lawyer'
          %i[client_name time meeting_method]
        when 'org_manage'
          %i[lawyer_id client_name time meeting_method]
        when 'admin'
          %i[lawyer_id organization_id client_id client_name]
        else
          []
        end
      end

      def filter_forced_params
        case user.account_type
        when 'client'
          { client_id: user.id }
        when 'lawyer'
          { lawyer_id: Api::V1::Repositories::LawyerProfileRepository.find_by!(user_id: user.id).id }
        when 'org_manage'
          { organization_id: Api::V1::Repositories::OrganizationRepository.find_by!(owner_id: user.id).id }
        else
          {}
        end
      end

      def show?
        case user.account_type
        when 'client'
          record.client_id == user.id
        when 'lawyer'
          Api::V1::Repositories::LawyerProfileRepository.find_by!(user_id: user.id).id == record.lawyer_id
        else
          false
        end
      rescue ActiveRecord::RecordNotFound
        false
      end

      # rubocop:disable Metrics/AbcSize
      def update?
        case user.account_type
        when 'client'
          record.client_id == user.id
        when 'lawyer'
          Api::V1::Repositories::LawyerProfileRepository.find_by!(user_id: user.id).id == record.lawyer_id
        when 'org_manage'
          Api::V1::Repositories::OrganizationRepository.find_by!(owner_id: user.id).id == record.organization_id
        else
          false
        end
      end
      # rubocop:enable Metrics/AbcSize

      def create?
        user.client?
      end

      def destroy?
        record.client_id == user.id || record.lawyer_id = user.id
      end
    end
  end
end
