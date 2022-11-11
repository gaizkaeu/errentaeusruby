# frozen_string_literal: true

require 'application_system_test_case'

class TaxIncomesTest < ApplicationSystemTestCase
  setup do
    @tax_income = tax_incomes(:one)
  end

  test 'visiting the index' do
    visit tax_incomes_url
    assert_selector 'h1', text: 'Tax incomes'
  end

  test 'should create tax income' do
    visit tax_incomes_url
    click_on 'New tax income'

    fill_in 'Estimation', with: @tax_income.estimation_id
    check 'Paid' if @tax_income.paid
    fill_in 'Price', with: @tax_income.price
    fill_in 'Status', with: @tax_income.status
    fill_in 'User', with: @tax_income.user_id
    click_on 'Create Tax income'

    assert_text 'Tax income was successfully created'
    click_on 'Back'
  end

  test 'should update Tax income' do
    visit tax_income_url(@tax_income)
    click_on 'Edit this tax income', match: :first

    fill_in 'Estimation', with: @tax_income.estimation_id
    check 'Paid' if @tax_income.paid
    fill_in 'Price', with: @tax_income.price
    fill_in 'Status', with: @tax_income.status
    fill_in 'User', with: @tax_income.user_id
    click_on 'Update Tax income'

    assert_text 'Tax income was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Tax income' do
    visit tax_income_url(@tax_income)
    click_on 'Destroy this tax income', match: :first

    assert_text 'Tax income was successfully destroyed'
  end
end
