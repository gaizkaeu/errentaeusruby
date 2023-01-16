module Api
  module V1
    require 'stripe'
    class TaxIncomesController < ::ApiBaseController
      before_action :authenticate

      before_action :set_tax_income, except: %i[index create]

      include TaxIncomesHelper

      # rubocop:disable Metrics/AbcSize
      def index
        if current_user.lawyer?
          lawyer_profile = Api::V1::Repositories::LawyerProfileRepository.find_by!(user_id: current_user.id)
          tax_incomes = Api::V1::Repositories::TaxIncomeRepository.filter(filtering_params.merge!(lawyer_id: lawyer_profile.id))
        else
          tax_incomes = Api::V1::Repositories::TaxIncomeRepository.filter(filtering_params.merge!(client_id: current_user.id))
        end
        render json: Api::V1::Serializers::TaxIncomeSerializer.new(tax_incomes).serializable_hash
      end
      # rubocop:enable Metrics/AbcSize

      # GET /tax_incomes/1 or /tax_incomes/1.json
      def show
        render json: Api::V1::Serializers::TaxIncomeSerializer.new(@tax_income).serializable_hash
      end

      # POST /tax_incomes or /tax_incomes.json
      def create
        @tax_income = Api::V1::Services::CreateTaxService.new.call(current_user, parse_params(tax_income_params_create, nested_estimation_params[:token]))
        if @tax_income.persisted?
          render json: Api::V1::Serializers::TaxIncomeSerializer.new(@tax_income).serializable_hash
        else
          render json: @tax_income.errors, status: :unprocessable_entity
        end
      end

      def documents
        authorize @tax_income
        @documents = @tax_income.documents.with_attached_files
        render 'documents/index'
      end

      def checkout
        pi = Api::V1::Services::TaxPaymentIntentService.new.call(current_user, @tax_income.id)
        if pi.present?
          render json: { clientSecret: pi[0], amount: pi[1] }
        else
          render json: { error: 'Not able to pay' }, status: :unprocessable_entity
        end
      end

      def payment_data
        authorize @tax_income
        if @tax_income.payment_intent_id
          payment_data = Stripe::PaymentIntent.retrieve(@tax_income.payment_intent_id)
          render json: payment_data
        else
          render json: { status: 'no_payment_intent' }
        end
      end

      # PATCH/PUT /tax_incomes/1 or /tax_incomes/1.json
      def update
        @tax_income = Api::V1::Services::UpdateTaxService.new.call(current_user, @tax_income, tax_income_params_update)
        if @tax_income.errors.empty?
          render json: Api::V1::Serializers::TaxIncomeSerializer.new(@tax_income).serializable_hash
        else
          render json: @tax_income.errors, status: :unprocessable_entity
        end
      end

      # DELETE /tax_incomes/1 or /tax_incomes/1.json
      def destroy
        authorize @tax_income
        @tax_income.destroy!

        head :no_content
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_tax_income
        @tax_income = Api::V1::Services::FindTaxService.new.call(current_user, params[:id])
      end

      # Only allow a list of trusted parameters through.
      def tax_income_params_create
        params.require(:tax_income).permit(TaxIncomePolicy.new(current_user, nil).permitted_attributes_create).with_defaults(client_id: current_user.id)
      end

      def tax_income_params_update
        params.require(:tax_income).permit(TaxIncomePolicy.new(current_user, nil).permitted_attributes_update)
      end

      def nested_estimation_params
        params.require(:estimation).permit(:token)
      end

      def filtering_params
        params.slice(Api::V1::Repositories::TaxIncomeRepository::FILTER_KEYS)
      end
    end
  end
end
