require 'test_helper'

class PicturesViewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:view_test_user_1)
    sign_in @user
    @picture = pictures(:vtu1_january)
  end

  test 'index page contains name of authenticated user' do
    get pictures_url
    assert_response :success
    assert_select 'h1', "Welcome #{@user.fullname}"
  end
end
