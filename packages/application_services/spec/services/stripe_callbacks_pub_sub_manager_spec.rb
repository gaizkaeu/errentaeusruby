require 'rails_helper'

RSpec.describe StripeCallbacksPubSubManager do
  subject(:pubsub) { described_class.new }

  before do
    stub_const(
      'PubSubTestJob',
      Class.new(ApplicationJob) do
        def perform(params); end
      end
    )
    stub_const(
      'PubSubTestService',
      Class.new(ApplicationService) do
        def call(params); end
      end
    )
  end

  describe '#call' do
    # rubocop:disable RSpec/MessageSpies
    # rubocop:disable RSpec/MessageExpectation
    context 'when synchronous is true' do
      it 'calls the service with the event' do
        pubsub.subscribe(PubSubTestService, /tax_*/, synchronous: true)
        event = { data: { object: { metadata: { type: 'tax_invoice' } } } }
        expect(PubSubTestService).to receive(:call)

        pubsub.call(event)
      end
    end
    # rubocop:enable RSpec/MessageExpectation
    # rubocop:enable RSpec/MessageSpies

    context 'when synchronous is false' do
      it 'calls the service with the event' do
        pubsub.subscribe(PubSubTestJob, /tax_*/, synchronous: false)
        event = { data: { object: { metadata: { type: 'tax_invoice' } } } }

        expect { pubsub.call(event) }
          .to have_enqueued_job(PubSubTestJob)
      end
    end
  end

  describe '#subscribe' do
    context 'when synchronous is true' do
      it 'raises an error if the service does not inherit from ApplicationService' do
        expect do
          pubsub.subscribe(PubSubTestJob, /tax_*/, synchronous: true)
        end.to raise_error(StripeCallbacksPubSubManager::NotAServiceError)
      end

      it 'does not raise an error if the service inherits from ApplicationService' do
        expect do
          pubsub.subscribe(PubSubTestService, /tax_*/, synchronous: true)
        end.not_to raise_error
      end
    end

    context 'when synchronous is false' do
      it 'raises an error if the service does not inherit from ApplicationJob' do
        expect do
          pubsub.subscribe(PubSubTestService, /tax_*/, synchronous: false)
        end.to raise_error(StripeCallbacksPubSubManager::NotAJobError)
      end

      it 'does not raise an error if the service inherits from ApplicationJob' do
        expect do
          pubsub.subscribe(PubSubTestJob, /tax_*/, synchronous: false)
        end.not_to raise_error
      end
    end
  end
end
