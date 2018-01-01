require 'test_helper'

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

  test 'fullname must be unique' do
    user = users(:duplicate_fullname_user_2)
    refute user.valid?
  end

  test 'fullname must be unique case insensitive' do
    user = users(:duplicate_fullname_insensitive_user)
    refute user.valid?
  end
end
