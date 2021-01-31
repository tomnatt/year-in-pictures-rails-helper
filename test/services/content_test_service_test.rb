require 'test_helper'
require 'content_test_service'

# Test ContentTestService
class ContentTestServiceTest < ActiveSupport::TestCase
  test 'finds an ending fullstop' do
    text = 'Words.'
    assert_not(ContentTestService.no_ending_fullstop(text), 'Should reject trailing fullstop')
  end

  test 'does not confuse an ellipsis' do
    text = 'Words...'
    assert(ContentTestService.no_ending_fullstop(text), 'Should accept trailing ellipsis')
  end

  test 'passes no trailing punctuation' do
    text = 'Words'
    assert(ContentTestService.no_ending_fullstop(text), 'Should accept no trailing punctuation')
  end

  test 'passes training exclamation mark' do
    text = 'Words!'
    assert(ContentTestService.no_ending_fullstop(text), 'Should accept trailing exclamation mark')
  end

  test 'passes training question mark' do
    text = 'Words?'
    assert(ContentTestService.no_ending_fullstop(text), 'Should accept trailing question mark')
  end

  # test 'runner method runs all tests' do
  # end
end
