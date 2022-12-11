require 'rails_helper'

RSpec.describe 'Accounts' do
  context 'when logged in lawyer' do
    let(:user) { create(:lawyer) }

    let(:authorized_headers) { user.create_new_auth_token }

    describe 'INDEX /accounts' do
      it 'renders a successful response' do
        get api_v1_accounts_url, as: :json, headers: authorized_headers
        expect(response).to be_successful
      end

      it 'can query users by name' do
        get api_v1_accounts_path, params: { first_name: user.first_name }, headers: authorized_headers
        expect(response).to be_successful
        expect(body).to match(user.first_name)
      end
    end

    describe 'SHOW /accounts' do
      it 'renders a user successfully' do
        get api_v1_account_url(user.id), as: :json, headers: authorized_headers
        expect(response).to be_successful
        expect(JSON.parse(body).symbolize_keys!).to match(a_hash_including({ first_name: user.first_name, last_name: user.last_name }))
      end
    end
  end

  context 'when logged in confirmed' do
    let(:user) { create(:user) }

    let(:authorized_headers) { user.create_new_auth_token }

    describe 'GET /logged_in' do
      it 'renders a successful response' do
        get api_v1_account_logged_in_url, as: :json, headers: authorized_headers
        expect(response).to be_successful
        expect(JSON.parse(response.body).symbolize_keys!).to match(a_hash_including(id: user.id, first_name: user.first_name, confirmed: true))
      end
    end

    describe 'POST /resend_confirmation' do
      it 'renders error' do
        post api_v1_account_resend_confirmation_path(user.id), as: :json, headers: authorized_headers
        expect(response).not_to be_successful
        expect(body).to match('error')
      end
    end

    describe 'GET /accounts' do
      it 'renders error' do
        get api_v1_accounts_url, as: :json, headers: authorized_headers
        expect(response).not_to be_successful
        expect(body).to match('not authorized')
      end
    end
  end

  context 'when logged in unconfirmed' do
    let(:user) { create(:unconfirmed_user) }

    let(:authorized_headers) { user.create_new_auth_token }

    describe 'GET /logged_in' do
      it 'renders a successful response' do
        get api_v1_account_logged_in_url, as: :json, headers: authorized_headers
        expect(response).to be_successful
        expect(JSON.parse(response.body).symbolize_keys!).to match(a_hash_including(id: user.id, first_name: user.first_name, confirmed: false))
      end
    end

    describe 'POST /resend_confirmation' do
      it 'with confirmation sent at > 5m' do
        user.update!(confirmation_sent_at: '04-07-2020')
        post api_v1_account_resend_confirmation_path(user.id), as: :json, headers: authorized_headers
        expect(response).to be_successful
      end

      it 'with confirmation sent at < 5m' do
        user.update!(confirmation_sent_at: Time.zone.now)
        post api_v1_account_resend_confirmation_path(user.id), as: :json, headers: authorized_headers
        expect(response).not_to be_successful
        expect(body).to match('error')
      end
    end
  end
end
