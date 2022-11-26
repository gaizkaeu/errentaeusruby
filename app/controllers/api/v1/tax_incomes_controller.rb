# frozen_string_literal: true

module Api
  module V1
    require 'stripe'
    class TaxIncomesController < ApiBaseController
      before_action :set_tax_income, except: %i[index create]
      before_action :authenticate_api_v1_user!

      # GET /tax_incomes or /tax_incomes.json
      def index
        @tax_incomes = current_api_v1_user.tax_incomes.includes(:lawyer)
      end

      # GET /tax_incomes/1 or /tax_incomes/1.json
      def show
        (render json: {error: "Not found"}, status: :unprocessable_entity) unless @tax_income
      end

      # GET /tax_incomes/1/edit
      def edit
      end

      # POST /tax_incomes or /tax_incomes.json
      def create
        estimation_attr = Estimation.decode_jwt_estimation(nested_estimation_params[:token])[0]
        @tax_income = current_api_v1_user.tax_incomes.build(tax_income_params.merge(estimation: estimation_attr))
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
        # TODO: ACCESS PERMISSIONS
        @tax_income = current_api_v1_user.tax_incomes.find_by(id: params[:id])
      end

      # Only allow a list of trusted parameters through.
      def tax_income_params
        params.require(:tax_income).permit(:observations)
      end
      def nested_estimation_params
        params.require(:estimation).permit(:token)
      end
    end
  end
end
