require 'test_helper'

class ContentTestTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:admin_user)
    sign_in @user
  end

  test 'content test shows correct results' do
    disable_javascript
    visit test_month_content_path(month: 8, year: 2018)

    # Check correct number of result blocks
    assert page.find_all('.results').length == 2, 'Incorrect number of result blocks'

    # Admin user picture
    admin_user_name = pictures(:month_view_admin).user.fullname
    # Check includes admin pic
    assert page.has_content?(admin_user_name),
           'Month view should list admin user pics'
    assert page.has_css?("##{admin_user_name.downcase.gsub(' ', '-')}.alert-danger"),
           'Admin pic should fail overall'
    assert page.find_all("##{admin_user_name.downcase.gsub(' ', '-')} li.alert-success").length == 6,
           'Admin pic should have mostly successes'
    assert page.find_all("##{admin_user_name.downcase.gsub(' ', '-')} li.alert-danger").length == 1,
           'Admin pic should have one specific failure'

    # Normal user picture
    normal_user_name = pictures(:month_view_normal).user.fullname
    # Check includes normal pic and omits pic from same user from a different year
    assert page.find_all("##{normal_user_name.downcase.gsub(' ', '-')}").length == 1,
           'Month view should list normal user pics from this year and not others'
    assert page.has_css?("##{normal_user_name.downcase.gsub(' ', '-')}.alert-success"),
           'Normal user pic should pass overall'
    assert page.find_all("##{normal_user_name.downcase.gsub(' ', '-')} li.alert-success").length == 7,
           'Normal pic should have all successes'
    assert page.find_all("##{normal_user_name.downcase.gsub(' ', '-')} li.alert-danger").empty?,
           'Normal pic should have no failures'

    # Check is omitting a disabled user pic
    refute page.has_content?(pictures(:month_view_disabled).user.fullname),
           'Month view should not list pics for disabled users'

    # Check no placeholder images
    refute page.has_content?('Placeholder'), 'Page should not contain placeholder entries'
  end
end
