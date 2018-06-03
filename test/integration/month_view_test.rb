require 'test_helper'

class MonthViewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:admin_user)
    sign_in @user
  end

  test 'list view has placeholders for active users' do
    visit month_view_path(month: 3)

    normal_placeholder = Picture.placeholder(users(:normal_user).fullname)
    assert page.has_content?(normal_placeholder.image), 'Month view should list active users'

    admin_placeholder = Picture.placeholder(users(:admin_user).fullname)
    assert page.has_content?(admin_placeholder.image), 'Month view should list admin users'

    disabled_placeholder = Picture.placeholder(users(:disabled_user).fullname)
    refute page.has_content?(disabled_placeholder.image), 'Month view should not list disabled users'
  end
end
