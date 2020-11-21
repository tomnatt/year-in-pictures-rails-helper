require 'test_helper'

class PicturesIndexTest < ActionDispatch::IntegrationTest
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

  test 'index page only lists active users' do
    visit pictures_path
    assert page.has_content?(users(:normal_user).fullname), 'Page does not list normal user'
    assert page.has_content?(users(:admin_user).fullname), 'Page does not list admin user'
    refute page.has_content?(users(:disabled_user).fullname), 'Page should not display disabled user'
  end

  test 'index page only contains images belonging to user' do
    get pictures_url
    displayed_pictures = css_select 'tbody > tr'
    owned_pictures = @user.pictures
    assert_equal owned_pictures.count, displayed_pictures.count
  end

  test 'index page links from lozenge to edit picture if picture exists for user only' do
    # Add picture for existing user
    pic = Picture.new(user:        users(:will_have_picture_no_admin_user),
                      image_title: 'Pic Exists',
                      caption:     'Pic Exists',
                      description: 'Pic Exists',
                      alt:         'Pic Exists')
    pic.save!

    sign_out @user
    sign_in users(:will_have_picture_no_admin_user)

    # Check picture belonging to different user is linked from the index page
    visit pictures_path
    photographer_with_picture_element = find '#will-have-picture-no-admin'
    assert_equal 'a', photographer_with_picture_element.tag_name, 'Incorrect type of element found'

    photographer_with_picture_uri = URI.parse(photographer_with_picture_element['href'])
    assert_equal edit_picture_path(pic), photographer_with_picture_uri.path, 'Incorrect link target'

    # Check lozenge for different user does not link
    photographer_without_picture_element = find '#will-not-have-picture-no-admin-logged-out'
    assert_equal 'p', photographer_without_picture_element.tag_name, 'Incorrect type of element found'
  end

  test 'index page links from lozenge to add picture if no picture for user only' do
    sign_out @user
    sign_in users(:will_not_have_picture_no_admin_user)

    # Check add picture page for same user is linked from the index page
    visit pictures_path
    photographer_without_picture_element = find '#will-not-have-picture-no-admin'
    assert_equal 'a', photographer_without_picture_element.tag_name, 'Incorrect type of element found'

    photographer_without_picture_uri = URI.parse(photographer_without_picture_element['href'])
    assert_equal new_picture_path, photographer_without_picture_uri.path, 'Incorrect link target'

    # Check lozenge for different user does not link
    photographer_without_picture_element = find '#will-not-have-picture-no-admin-logged-out'
    assert_equal 'p', photographer_without_picture_element.tag_name, 'Incorrect type of element found'
  end

  test 'for admin user index page links from lozenge to edit picture page if picture exists' do
    # Add picture for existing user
    pic = Picture.new(user:        users(:will_have_picture_admin_user),
                      image_title: 'Pic Exists',
                      caption:     'Pic Exists',
                      description: 'Pic Exists',
                      alt:         'Pic Exists')
    pic.save!

    sign_out @user
    sign_in users(:admin_user)

    # Check picture belonging to different user is linked from the index page
    visit pictures_path
    photographer_with_picture_element = find '#will-have-picture-admin'
    assert_equal 'a', photographer_with_picture_element.tag_name, 'Incorrect type of element found'

    photographer_with_picture_uri = URI.parse(photographer_with_picture_element['href'])
    assert_equal edit_picture_path(pic), photographer_with_picture_uri.path, 'Incorrect link target'
  end

  test 'for admin user index page links from lozenge to new picture page if no picture' do
    sign_out @user
    sign_in users(:admin_user)

    # Check add picture page for different user is linked from the index page
    visit pictures_path
    photographer_without_picture_element = find '#will-not-have-picture-admin'
    assert_equal 'a', photographer_without_picture_element.tag_name, 'Incorrect type of element found'

    photographer_without_picture_uri = URI.parse(photographer_without_picture_element['href'])
    assert_equal new_picture_path, photographer_without_picture_uri.path, 'Incorrect link target'
  end

  test 'index page lists all images for admin' do
    sign_out @user
    sign_in users(:admin_user)
    get pictures_url
    displayed_pictures = css_select 'tbody > tr'
    assert_equal Picture.count, displayed_pictures.count
  end
end
