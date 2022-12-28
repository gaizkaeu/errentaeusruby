require 'rails_helper'

describe LogAccountLoginJob do
  subject(:service) { described_class.new }

  let(:user_record) { create(:user) }
  let(:attributes_log) { attributes_for(:account_history, user_id: user_record.id) }
  let(:attributes_log_invalid) { attributes_for(:account_history, user_id: user_record.id).merge(action: nil) }

  describe '#perform' do
    it 'does create log with valid attributes' do
      expect do
        service.perform(attributes_log)
      end.to change(Api::V1::AccountHistoryRecord, :count).by(1)
    end

    it 'does not create log with valid attributes' do
      expect do
        service.perform(attributes_log_invalid)
      end.not_to change(Api::V1::AccountHistoryRecord, :count).by(1).and raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
