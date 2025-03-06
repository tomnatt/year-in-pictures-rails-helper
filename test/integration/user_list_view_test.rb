require 'test_helper'

class UserListViewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:admin_user)
    sign_in @user
  end

  # This is reusing data and may need separation in future
  test 'list view shows user' do
    visit users_list_path

    # Check includes admin users
    assert page.has_content?(users(:user_list_admin_user).email), 'List should include admin users'
    assert page.has_content?(users(:user_list_admin_user).fullname), 'List should include admin users'

    # Check includes normal users
    assert page.has_content?(users(:user_list_normal_user).email), 'List should include normal users'
    assert page.has_content?(users(:user_list_normal_user).fullname), 'List should include normal users'

    # Check includes disabled users
    assert page.has_content?(users(:user_list_disabled_user).email), 'List should include disabled users'
    assert page.has_content?(users(:user_list_disabled_user).fullname), 'List should include disabled users'
  end
end
