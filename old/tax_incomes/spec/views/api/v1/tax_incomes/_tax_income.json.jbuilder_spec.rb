require 'spec_helper'
# Define the test for the partial view
describe 'the tax_income partial' do
  it 'displays the data for a tax_income record' do
    # Generate sample data for a tax_income record using the factory
    tax_income = create(:tax_income)

    # Render the partial with the sample data
    render partial: 'tax_incomes/tax_income', locals: { tax_income: }

    # Use RSpec's expect method to verify that the partial is rendered correctly
    parsed_json = JSON.parse(response.body)
    expect(parsed_json['id']).to eq(tax_income.id)
    expect(parsed_json['state']).to eq(tax_income.state)
    expect(parsed_json['created_at']).to eq(tax_income.created_at.as_json)
    expect(parsed_json['updated_at']).to eq(tax_income.updated_at.as_json)

    # Add more expectations for the partial if necessary
  end
end
