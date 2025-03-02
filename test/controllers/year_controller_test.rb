require 'test_helper'

class YearControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:admin_user)
    sign_in @user
  end

  test 'must require authentication' do
    sign_out @user
    get '/year/2015'
    assert_response :redirect
  end

  test 'if authenticated, user must be admin' do
    sign_out @user
    sign_in users(:user_one)
    get '/year/2015'
    assert_response :redirect
  end

  test 'can authenticate with token' do
    sign_out @user
    get '/year/2015?token=testtoken'
    assert_response :success
  end

  test 'should get month list' do
    get '/year/2015'
    assert_response :success
  end
end
