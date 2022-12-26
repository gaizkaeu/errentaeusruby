require 'rails_helper'

RSpec.describe 'AccountHistory' do
  let(:user) { create(:user) }
  let(:lawyer) { create(:lawyer) }

  context 'when logged in lawyer' do
    before do
      sign_in(lawyer)
    end

    describe 'index /:id/history' do
      it 'renders a successful response' do
        authorized_get api_v1_account_history_url(user.id), as: :json
        expect(response).to be_successful
      end
    end
  end

  context 'when logged in user' do
    before do
      sign_in(user)
    end

    describe 'index /:id/history' do
      it 'renders a successful response' do
        authorized_get api_v1_account_history_url(user.id), as: :json
        expect(response).to be_successful
      end
      
      it 'renders error when user is not the same' do
        authorized_get api_v1_account_history_url(lawyer.id), as: :json
        expect(response).to be_forbidden
      end
    end
  end

  context 'when not logged in' do
    describe 'index /:id/history' do
      it 'renders error' do
        authorized_get api_v1_account_history_url(user.id), as: :json
        expect(response).to be_unauthorized
      end
    end
  end
end
