module Api
  module V1
    require 'stripe'
    class TaxIncomesController < ApiBaseController
      include TaxIncomesHelper
      before_action :authenticate_api_v1_user!

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
        @tax_income = current_api_v1_user.tax_incomes.build
        authorize @tax_income
        @tax_income.update(parse_params(tax_income_params, nested_estimation_params[:token]))

        respond_to do |format|
          if @tax_income.save
            format.json { render :show, status: :ok }
          else
            format.json { render json: @tax_income.errors, status: :unprocessable_entity }
          end
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
          render json: { clientSecret: intent[0], amount: intent[1]}
        else
          render json: { error: 'Not able to pay' }, status: :unprocessable_entity
        end
      end

      def payment_data
        authorize @tax_income
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
        authorize @tax_income
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

      def filtering_params
        return unless current_api_v1_user.lawyer?
          params.slice(:first_name)
      end

    end
  end
end
