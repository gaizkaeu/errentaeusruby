# frozen_string_literal: true

class ApplicationController < ActionController::API
  append_view_path(Rails.root.glob('packages/*/app/views'))

  include Pagy::Backend
end
