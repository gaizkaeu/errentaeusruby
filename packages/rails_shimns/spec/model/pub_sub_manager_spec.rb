require 'rails_helper'

RSpec.describe PubSubManager do
  before do
    stub_const(
      'PubSubTestJob',
      Class.new(ApplicationJob) do
        def perform(params); end
      end
    )
  end

  it 'allows registering events, subscribing to events, and publishing events to enqueue jobs' do
    ActiveJob::Base.queue_adapter = :test
    pub_sub = described_class.new
    pub_sub.register_event('test.event') do
      name String
    end
    pub_sub.subscribe('test.event', PubSubTestJob)

    expect do
      pub_sub.publish('test.event', name: 'my name')
    end.to enqueue_job(PubSubTestJob).with(name: 'my name')
  end

  it 'raises if an event is registered twice' do
    pub_sub = described_class.new

    pub_sub.register_event('test.event') do
      name String
    end

    expect do
      pub_sub.register_event('test.event') do
        name String
      end
    end.to raise_error(PubSubManager::EventAlreadyRegisteredError, 'PubSub event test.event already registered')
  end

  it 'raises UnregisteredEventError if the event is not registered when subscribing' do
    pub_sub = described_class.new

    expect do
      pub_sub.subscribe('test.event', PubSubTestJob)
    end.to raise_error(PubSubManager::UnregisteredEventError, 'Unknown PubSub event test.event')
  end

  it 'raises NotAJobError if the job does not inherit from ApplicationJob' do
    pub_sub = described_class.new
    pub_sub.register_event('test.event') do
      name String
    end

    expect do
      pub_sub.subscribe('test.event', Api::V1::User)
    end.to raise_error(PubSubManager::NotAJobError, 'Api::V1::User must inherit from ApplicationJob')
  end

  it 'raises UnregisteredEventError if the event is not registered when publishing' do
    pub_sub = described_class.new

    expect do
      pub_sub.publish('test.event', name: 'my name')
    end.to raise_error(PubSubManager::UnregisteredEventError, 'Unknown PubSub event test.event')
  end

  it 'raises UnrecognizedAttributes if the event is passed a key it was not registered with' do
    pub_sub = described_class.new
    pub_sub.register_event('test.event') do
      name String
    end

    expect do
      pub_sub.publish('test.event', not_name: 'some value')
    end.to raise_error(ValueSemantics::UnrecognizedAttributes, '`PubSub event test.event` does not define attributes: `:not_name`')
  end

  it 'raises InvalidValue if the event is passed a value of the wrong type' do
    pub_sub = described_class.new
    pub_sub.register_event('test.event') do
      name String
    end

    expect do
      pub_sub.publish('test.event', name: 1)
    end.to raise_error(ValueSemantics::InvalidValue, "Some attributes of `PubSub event test.event` are invalid:\n  - name: 1\n")
  end
end
