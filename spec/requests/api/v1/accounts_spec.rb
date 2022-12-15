require 'rails_helper'

RSpec.describe 'Accounts' do
  context 'when logged in lawyer' do
    let(:user) { create(:lawyer) }

    before do
      sign_in(user)
    end

    describe 'INDEX /accounts' do
      it 'renders a successful response' do
        authorized_get api_v1_accounts_url, as: :json
        expect(response).to be_successful
      end

      # it "can query users by name" do
      #   authorized_get api_v1_accounts_url, as: :json, params: {first_name: user.first_name}
      #   expect(response).to be_successful
      #   expect(body).to match(user.first_name)
      # end
    end

    describe 'SHOW /accounts' do
      it 'renders a user successfully' do
        authorized_get api_v1_account_url(user.id), as: :json
        expect(response).to be_successful
        expect(JSON.parse(body).symbolize_keys!).to match(a_hash_including({ first_name: user.first_name, last_name: user.last_name }))
      end
    end
  end

  context 'when logged in confirmed' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
    end

    # describe "POST /resend_confirmation" do
    #   it "renders error" do
    #     post api_v1_account_resend_confirmation_path(user.id), as: :json
    #     expect(response).not_to be_successful
    #     expect(body).to match("error")
    #   end
    # end

    describe 'GET /accounts' do
      it 'renders error' do
        authorized_get api_v1_accounts_url, as: :json
        expect(response).not_to be_successful
        expect(body).to match('not authorized')
      end
    end
  end
end
