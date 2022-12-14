module Api
  module V1
    require 'stripe'
    class TaxIncomesController < ApiBaseController
      include TaxIncomesHelper
      before_action :authorize_access_request!

      before_action :set_tax_income, except: %i[index create]

      after_action :verify_authorized, except: :index
      after_action :verify_policy_scoped, only: :index

      # GET /tax_incomes or /tax_incomes.json
      def index
        res = policy_scope(TaxIncome).order(updated_at: :desc)
        @tax_incomes = TaxIncome.filter(filtering_params, res)
      end

      # GET /tax_incomes/1 or /tax_incomes/1.json
      def show
        authorize @tax_income
      end

      # POST /tax_incomes or /tax_incomes.json
      # rubocop:disable Rails/SaveBang
      def create
        @tax_income = current_user.tax_incomes.build
        @tax_income.update(parse_params(tax_income_params, nested_estimation_params[:token]))
        authorize @tax_income

        if @tax_income.save
          render :show, status: :ok
        else
          render json: @tax_income.errors, status: :unprocessable_entity
        end
      end
      # rubocop:enable Rails/SaveBang

      def documents
        authorize @tax_income
        @documents = @tax_income.documents.with_attached_files
        render 'api/v1/documents/index'
      end

      def checkout
        authorize @tax_income
        if @tax_income.waiting_payment?
          intent = @tax_income.retrieve_payment_intent
          render json: { clientSecret: intent[0], amount: intent[1] }
        else
          render json: { error: 'Not able to pay' }, status: :unprocessable_entity
        end
      end

      def payment_data
        authorize @tax_income
        if @tax_income.payment
          payment_data = Stripe::PaymentIntent.retrieve(@tax_income.payment)
          render partial: 'api/v1/payment/payment_data', locals: { payment: payment_data }
        else
          render json: { error: 'No payment data' }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /tax_incomes/1 or /tax_incomes/1.json
      def update
        authorize @tax_income
        if @tax_income.update(tax_income_params)
          render :show, status: :ok, location: @tax_income
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
        @tax_income = policy_scope(TaxIncome).find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def tax_income_params
        params.require(:tax_income).permit(policy(@tax_income).permitted_attributes)
      end

      def nested_estimation_params
        params.require(:estimation).permit(:token)
      end

      def filtering_params
        return unless current_user.lawyer?

        params.slice(:first_name)
      end
    end
  end
end
