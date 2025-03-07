require 'test_helper'

# Test User model
class UserTest < ActiveSupport::TestCase
  test 'find user if present' do
    user = User.find_by_fullname_or_placeholder('test one')
    assert_equal 'test one', user.fullname
    assert_equal 'test@example.com', user.email
    assert_not_nil user.id, 'User id should not be nil as it is in database'
  end

  test 'default to placeholder user if no user found' do
    user = User.find_by_fullname_or_placeholder('random')
    assert_equal 'random', user.fullname
    assert_equal 'nothing@example.com', user.email
    assert_nil user.id, 'User id should be nil as it is not in database'
  end

  test 'email address must be unique' do
    duplicate_email_user = User.new(email: 'secondtest@example.com', fullname: 'duplicate email')
    refute duplicate_email_user.valid?
  end

  test 'fullname must be unique' do
    duplicate_fullname_user = User.new(email: 'dfu2@example.com', fullname: 'test three')
    refute duplicate_fullname_user.valid?
  end

  test 'fullname must be unique case insensitive' do
    duplicate_fullname_case_insensitive_user = User.new(email: 'dfui@example.com', fullname: 'TeST TwO')
    refute duplicate_fullname_case_insensitive_user.valid?
  end

  test 'admin user is active for authentication' do
    user = users(:admin_user)
    assert user.active_for_authentication?
  end

  test 'normal user is active for authentication' do
    user = users(:normal_user)
    assert user.active_for_authentication?
  end

  test 'disabled user is not active for authentication' do
    user = users(:disabled_user)
    refute user.active_for_authentication?
  end

  test 'all_active only returns active users' do
    all_active_users = []
    users.each do |u|
      all_active_users << u unless u.disabled?
    end

    assert_equal all_active_users.count, User.all_active.count
  end

  test 'user has picture for this month' do
    user = users(:better_guess_user)

    # User should not have a picture for July
    travel_to Time.new(2018, 7, 25).in_time_zone
    refute user.picture_for_last_month?, 'User should not have a picture for July'

    # User should have a picture for May
    travel_to Time.new(2018, 5, 25).in_time_zone
    assert user.picture_for_last_month?, 'User should have a picture for May'
  end

  test 'correct output format' do
    id = 500
    fullname = 'Boris Exampleface'
    email = 'example@example.com'

    user = User.new
    user.id = id
    user.fullname = fullname
    user.email = email

    expected_output = <<OUTPUT
  -
    id: #{id}
    name: #{fullname}
OUTPUT

    assert_equal expected_output, user.yaml_output, 'YAML output has changed'
  end
end
