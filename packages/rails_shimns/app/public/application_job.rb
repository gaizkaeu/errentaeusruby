# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  include Cloudtasker::Worker unless Rails.env.test?
end
