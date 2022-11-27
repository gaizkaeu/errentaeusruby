module Api
  module V1
    require 'stripe'
    class TaxIncomesController < ApiBaseController
      include TaxIncomesHelper
      before_action :authenticate_api_v1_user!

      before_action :set_tax_income, except: %i[index create]

      after_action :verify_authorized, except: :index
      after_action :verify_policy_scoped, only: :index

      rescue_from ActiveRecord::RecordNotFound, with: :tax_income_not_found

      # GET /tax_incomes or /tax_incomes.json
      def index
        @tax_incomes = policy_scope(TaxIncome)
      end

      # GET /tax_incomes/1 or /tax_incomes/1.json
      def show
        authorize @tax_income
        (render json: {error: "Not found"}, status: :unprocessable_entity) unless @tax_income
      end

      # POST /tax_incomes or /tax_incomes.json
      def create
        @tax_income = TaxIncome.new
        authorize @tax_income
        @tax_income.update!(parse_params(tax_income_params, nested_estimation_params[:token]))

        respond_to do |format|
          if @tax_income.save
            format.json { render :show, status: :ok }
          else
            format.json { render json: @tax_income.errors, status: :unprocessable_entity }
          end
        end
      end

      def documents
        @documents = @tax_income.documents.with_attached_files
        render 'api/v1/documents/index'
      end

      def checkout
        if @tax_income.waiting_payment?
          payment_intent = BillingService::StripeService.create_payment_intent(
            @tax_income.price, {id: @tax_income.id}, @tax_income.user.stripe_customer_id
          )
          render json: { clientSecret: payment_intent }
        else
          render json: { error: 'Not able to pay' }, status: :unprocessable_entity
        end
      end

      def payment_data
        if @tax_income.payment
          payment_data = Stripe::PaymentIntent.retrieve(
            @tax_income.payment
          )
          render partial: 'api/v1/payment/payment_data', locals: { payment: payment_data }
        else
          render json: { error: 'No payment data' }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /tax_incomes/1 or /tax_incomes/1.json
      def update
        authorize @tax_income
        respond_to do |format|
          if @tax_income.update(tax_income_params)
            format.json { render :show, status: :ok, location: @tax_income }
          else
            format.json { render json: @tax_income.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /tax_incomes/1 or /tax_incomes/1.json
      def destroy
        @tax_income.destroy!

        respond_to do |format|
          format.json { head :no_content }
        end
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

      def tax_income_not_found
        render json: {error: "tax income not found"}, status: :unprocessable_entity
      end
    end
  end
end
