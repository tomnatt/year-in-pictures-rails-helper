require 'test_helper'

class PicturesViewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:view_test_user_1)
    sign_in @user
  end

  test 'index page contains name of authenticated user' do
    visit pictures_path
    assert '200', page.status_code
    assert page.has_css?('h1')
    assert_equal "Welcome #{@user.fullname}", page.first(:css, 'h1').text
  end

  test 'index page only contains images belonging to user' do
    get pictures_url
    displayed_pictures = css_select 'tbody > tr'
    owned_pictures = @user.pictures
    assert_equal owned_pictures.count, displayed_pictures.count
  end

  test 'index page lists all images for admin' do
    sign_out @user
    sign_in users(:admin_user)
    get pictures_url
    displayed_pictures = css_select 'tbody > tr'
    assert_equal Picture.count, displayed_pictures.count
  end
end
