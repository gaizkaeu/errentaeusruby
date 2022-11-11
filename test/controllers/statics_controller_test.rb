# frozen_string_literal: true

require 'test_helper'

class StaticsControllerTest < ActionDispatch::IntegrationTest
  test 'should get manifest' do
    get statics_manifest_url
    assert_response :success
  end
end
