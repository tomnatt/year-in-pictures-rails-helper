require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:admin_user)
    sign_in @user
  end

  test 'must require authentication' do
    sign_out @user
    get users_url
    assert_response :redirect
  end

  test 'user must be admin' do
    sign_out @user
    sign_in users(:user_one)
    get users_url
    assert_response :redirect
  end

  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should get new' do
    get new_user_url
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url, params: { user: {
        email:                 'createnew@example.com',
        password:              'longenoughpassword',
        password_confirmation: 'longenoughpassword',
        fullname:              'Name',
        role:                  'disabled'
      } }
    end

    assert_redirected_to user_url(User.last)
  end

  test 'should show user' do
    get user_url(@user)
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_url(@user)
    assert_response :success
  end

  test 'should update user' do
    patch user_url(@user), params: { user: {
      email: 'newemail@example.com'
    } }
    assert_redirected_to user_url(@user)
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete user_url(users(:user_to_delete))
    end

    assert_redirected_to users_url
  end

  # For the user list page
  test 'user list must require authentication' do
    sign_out @user
    get users_list_url
    assert_response :redirect
  end

  test 'user list if authenticated, user must be admin' do
    sign_out @user
    sign_in users(:user_one)
    get users_list_url
    assert_response :redirect
  end

  test 'user list can authenticate with token' do
    sign_out @user
    get users_list_url(token: 'testtoken')
    assert_response :success
  end

  test 'user list should get user list' do
    get users_list_url
    assert_response :success
  end
end
