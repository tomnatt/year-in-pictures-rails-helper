require 'test_helper'

class MonthControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:user_one)
  end

  test 'must require authentication' do
    sign_out users(:user_one)
    get '/month/1'
    assert_response :redirect
  end

  test 'should get month list' do
    get '/month/1'
    assert_response :success
  end
end
