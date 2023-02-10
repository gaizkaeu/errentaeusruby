require 'rails_helper'

RSpec.describe 'Transactions' do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:organization) { create(:organization) }
  let(:transaction_list) { create_list(:transaction, 2) }

  context 'when logged in admin' do
    before do
      sign_in(admin)
    end

    describe 'index /' do
      it 'renders a successful response' do
        Api::V1::Repositories::TransactionRepository.add(attributes_for(:transaction, user_id: user.id, organization_id: organization.id))
        authorized_get api_v1_transactions_url, as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data'].size).to eq(1)
      end
    end
  end

  context 'when logged in user' do
    before do
      sign_in(user)
    end

    describe 'index /' do
      it 'user can only query his transactions' do
        create_list(:transaction, 5)
        Api::V1::Repositories::TransactionRepository.add(attributes_for(:transaction, user_id: user.id, organization_id: organization.id))

        authorized_get api_v1_transactions_url, as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data'].size).to eq(1)
      end

      it 'cannot query other users transactions' do
        create_list(:transaction, 5)
        Api::V1::Repositories::TransactionRepository.add(attributes_for(:transaction, user_id: admin.id, organization_id: organization.id))

        authorized_get api_v1_transactions_url(client_id: admin.id), as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data'].size).to eq(0)
      end
    end
  end

  context 'when logged in lawyer' do
    let(:lawyer) { create(:lawyer) }

    before do
      sign_in(lawyer)
    end

    describe 'index /' do
      it 'cannot query transactions' do
        create_list(:transaction, 5)
        Api::V1::Repositories::TransactionRepository.add(attributes_for(:transaction, user_id: user.id, organization_id: organization.id))

        authorized_get api_v1_transactions_url, as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data'].size).to eq(0)
      end
    end
  end

  context 'when organization owner logged in' do
    before do
      sign_in(organization.owner)
    end

    describe 'index /' do
      it 'can query only his transactions' do
        create_list(:transaction, 5, organization_id: organization.id)
        create_list(:transaction, 5)

        authorized_get api_v1_transactions_url, as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data'].size).to eq(0)
      end
    end
  end
end
