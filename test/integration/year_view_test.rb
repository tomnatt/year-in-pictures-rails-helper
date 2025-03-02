require 'test_helper'

class YearViewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:admin_user)
    sign_in @user
  end

  # This is reusing test data from month_view_test - may need to split in future
  test 'list view shows given year pictures' do
    visit year_view_path(year: 2018)

    # Check includes admin pic
    assert page.has_content?(pictures(:month_view_admin).image_title),
           'Month view should list admin user pics'

    # Check includes normal pic
    assert page.has_content?(pictures(:month_view_normal).image_title),
           'Month view should list normal user pics'

    # Check is omitting a pic from a normal user from a different year
    refute page.has_content?(pictures(:month_view_normal_wrong_year).image_title),
           'Month view should not list pics from the wrong year'

    # Should include disabled user pic
    assert page.has_content?(pictures(:month_view_disabled).image_title),
           'Month view should not list pics for disabled users'

    # Check no placeholder images
    refute page.has_content?('Placeholder'), 'Page should not contain placeholder entries'
  end
end
