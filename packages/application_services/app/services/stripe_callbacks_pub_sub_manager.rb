class StripeCallbacksPubSubManager
  class NotAServiceError < StandardError; end
  class NotAJobError < StandardError; end

  def initialize
    @subscribers = []
  end

  def subscribe(service, regex_pattern, synchronous: false)
    if synchronous
      raise NotAServiceError, "#{service} must inherit from ApplicationService" unless service.ancestors.include?(ApplicationService)
    else
      raise NotAJobError, "#{service} must inherit from ApplicationJob" unless service.ancestors.include?(ApplicationJob)
    end

    @subscribers << { service:, regex_pattern:, synchronous: }
  end

  def call(event)
    payment_intent = event[:data][:object]
    @subscribers.each do |subscriber|
      if subscriber[:regex_pattern].match?(payment_intent[:metadata][:type])
        subscriber[:synchronous] ? subscriber[:service].call(event) : perform_job(subscriber[:service], event)
      end
    end
  end

  private

  def perform_job(job_class, event_payload)
    if Rails.env.test?
      job_class.perform_later(**event_payload)
    else
      job_class.perform_async(**event_payload)
    end
  end
end
