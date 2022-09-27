require "test_helper"

class AppointmentControllerTest < ActionDispatch::IntegrationTest
  test "should get user:references" do
    get appointment_user:references_url
    assert_response :success
  end

  test "should get time:datetime" do
    get appointment_time:datetime_url
    assert_response :success
  end

  test "should get tax_income:references" do
    get appointment_tax_income:references_url
    assert_response :success
  end
end
