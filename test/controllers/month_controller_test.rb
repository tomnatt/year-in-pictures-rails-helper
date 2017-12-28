require 'test_helper'

class MonthControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:user_one)
  end

  test 'should get month list' do
    get '/month/1'
    assert_response :success
  end
end
