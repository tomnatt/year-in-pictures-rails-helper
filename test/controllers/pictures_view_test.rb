require 'test_helper'

class PicturesViewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:view_test_user_1)
    sign_in @user
  end

  test 'index page contains name of authenticated user' do
    get pictures_url
    assert_response :success
    assert_select 'h1', "Welcome #{@user.fullname}"
  end

  test 'index page only contains images belonging to user' do
    get pictures_url
    displayed_pictures = css_select 'tbody > tr'
    owned_pictures = @user.pictures
    assert_equal owned_pictures.count, displayed_pictures.count
  end
end
