require 'test_helper'

class PicturesFormTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:admin_user)
    sign_in @user
  end

  test 'input form only lists active users' do
    # Disable Javascript by using the rack driver
    Capybara.current_driver = :rack_test

    visit new_picture_path

    assert page.has_content?('New Picture')
    assert page.has_css?('select#picture_user_id'), 'Photographer select not found'
    assert page.has_select?('picture_user_id', with_options: [users(:admin_user).fullname,
                                                              users(:normal_user).fullname])
    refute page.has_select?('picture_user_id', with_options: [users(:disabled_user).fullname]),
           'Photographer select should not contain disabled user'
  end
end
