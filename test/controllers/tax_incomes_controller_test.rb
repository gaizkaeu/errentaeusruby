# frozen_string_literal: true

require 'test_helper'

class TaxIncomesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tax_income = tax_incomes(:one)
  end

  test 'should get index' do
    get tax_incomes_url
    assert_response :success
  end

  test 'should get new' do
    get new_tax_income_url
    assert_response :success
  end

  test 'should show tax_income' do
    get tax_income_url(@tax_income)
    assert_response :success
  end

  test 'should get edit' do
    get edit_tax_income_url(@tax_income)
    assert_response :success
  end

  test 'should update tax_income' do
    patch tax_income_url(@tax_income),
          params: { tax_income: { estimation_id: @tax_income.estimation_id, paid: @tax_income.paid,
                                  price: @tax_income.price, status: @tax_income.status, user_id: @tax_income.user_id } }
    assert_redirected_to tax_income_url(@tax_income)
  end

  test 'should destroy tax_income' do
    assert_difference('TaxIncome.count', -1) do
      delete tax_income_url(@tax_income)
    end

    assert_redirected_to tax_incomes_url
  end
end
