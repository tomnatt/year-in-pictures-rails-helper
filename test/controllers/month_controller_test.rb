require 'test_helper'

class MonthControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:admin_user)
    sign_in @user
  end

  test 'must require authentication' do
    sign_out @user
    get '/month/1'
    assert_response :redirect
  end

  test 'user must be admin' do
    sign_out @user
    sign_in users(:user_one)
    get '/month/1'
    assert_response :redirect
  end

  test 'should get month list' do
    get '/month/1'
    assert_response :success
  end
end
