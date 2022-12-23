class PubSubManager
  EventAlreadyRegisteredError = Class.new(StandardError)
  UnregisteredEventError = Class.new(StandardError)
  NotAJobError = Class.new(StandardError)

  public_constant :EventAlreadyRegisteredError
  public_constant :UnregisteredEventError
  public_constant :NotAJobError

  def initialize
    @registered_events = {}
  end

  def register_event(event_name, &)
    if @registered_events[event_name].present?
      raise EventAlreadyRegisteredError, "PubSub event #{event_name} already registered"
    end

    payload_struct =
      Class.new(ValueStruct) do
        attributes(&)

        define_singleton_method(:to_s) do
          "PubSub event #{event_name}"
        end
      end

    @registered_events[event_name] = { payload_struct:, subscribers: [] }
  end

  def subscribe(event_name, job_class)
    registered_event = @registered_events[event_name]
    raise UnregisteredEventError, "Unknown PubSub event #{event_name}" if registered_event.blank?

    raise NotAJobError, "#{job_class} must inherit from ApplicationJob" unless job_class.ancestors.include?(ApplicationJob)

    registered_event[:subscribers] << job_class
  end

  def publish(event_name, event_payload, _subscriber_index = nil)
    registered_event = @registered_events[event_name]
    raise UnregisteredEventError, "Unknown PubSub event #{event_name}" if registered_event.blank?

    # verify the structure of the payload
    registered_event[:payload_struct].new(event_payload)

    registered_event[:subscribers].each do |job_class|
      if Rails.env.test?
        job_class.perform_later(**event_payload)
      else
        job_class.perform_async(**event_payload)
      end
    end
  end
end
