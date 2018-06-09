require 'test_helper'

class PicturesFormTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:admin_user)
    sign_in @user
  end

  test 'input form only lists active users' do
    disable_javascript
    visit new_picture_path

    assert page.has_content?('New Picture')
    assert page.has_css?('select#picture_user_id'), 'Photographer select not found'
    assert page.has_select?('picture_user_id', with_options: [users(:admin_user).fullname,
                                                              users(:normal_user).fullname])
    refute page.has_select?('picture_user_id', with_options: [users(:disabled_user).fullname]),
           'Photographer select should not contain disabled user'
  end

  test 'additional data is hidden on inital page load' do
    visit new_picture_path

    assert page.has_content?('Extra information'), 'Words should be visible'
    refute page.has_content?('You can probably ignore these fields'), 'With js enable words should not be visible'
  end

  test 'additional data is visible when javascript disabled on inital page load' do
    disable_javascript
    visit new_picture_path

    assert page.has_content?('Extra information'), 'Words should be visible'
    assert page.has_content?('You can probably ignore these fields'), 'With js disabled, words should be visible'
  end
end
