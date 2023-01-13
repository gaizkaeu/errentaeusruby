require 'rails_helper'

RSpec.describe 'Accounts' do
  context 'when logged in lawyer' do
    let(:user) { create(:user) }
    let(:lawyer) { create(:lawyer) }

    before do
      sign_in(user)
    end

    describe 'show /lawyer' do
      it 'renders a successful response' do
        authorized_get api_v1_lawyer_url(lawyer.id), as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data']['attributes'].symbolize_keys!).to match(a_hash_including(lawyer.attributes.symbolize_keys!.slice(:first_name, :last_name, :email)))
      end
    end
  end
end
