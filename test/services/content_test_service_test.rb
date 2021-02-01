require 'test_helper'
require 'content_test_service'

# Test ContentTestService
class ContentTestServiceTest < ActiveSupport::TestCase
  test 'no_ending_fullstop finds an ending full stop' do
    text = 'Words.'
    assert_not(ContentTestService.no_ending_fullstop(text), 'Should reject trailing full stop')
  end

  test 'no_ending_fullstop does not confuse an ellipsis' do
    text = 'Words...'
    assert(ContentTestService.no_ending_fullstop(text), 'Should accept trailing ellipsis')
  end

  test 'no_ending_fullstop passes no trailing punctuation' do
    text = 'Words'
    assert(ContentTestService.no_ending_fullstop(text), 'Should accept no trailing punctuation')
  end

  test 'no_ending_fullstop passes training exclamation mark' do
    text = 'Words!'
    assert(ContentTestService.no_ending_fullstop(text), 'Should accept trailing exclamation mark')
  end

  test 'no_ending_fullstop passes training question mark' do
    text = 'Words?'
    assert(ContentTestService.no_ending_fullstop(text), 'Should accept trailing question mark')
  end

  test 'ellipsis_are_three_dots passes a trailing three dot ellipsis' do
    text = 'So...'
    assert(ContentTestService.ellipsis_are_three_dots(text), 'Should accept three dots')
  end

  test 'ellipsis_are_three_dots passes a three dot ellipsis in the middle of the phrase' do
    text = 'So... how does this work?'
    assert(ContentTestService.ellipsis_are_three_dots(text), 'Should accept three dots')
  end

  test 'ellipsis_are_three_dots is not confused by a trailing full stop' do
    text = 'Words.'
    assert(ContentTestService.ellipsis_are_three_dots(text), 'Should ignore trailing full stop')
  end

  test 'ellipsis_are_three_dots is not confused by a full stop mid-phrase' do
    text = 'Words. Here goes!'
    assert(ContentTestService.ellipsis_are_three_dots(text), 'Should ignore mid-phrase full stop')
  end

  test 'ellipsis_are_three_dots rejects more than three dots' do
    text = 'Words.... Here goes!'
    assert_not(ContentTestService.ellipsis_are_three_dots(text), 'Should reject four dots')

    text = 'Words...... Here goes!'
    assert_not(ContentTestService.ellipsis_are_three_dots(text), 'Should reject more than four dots')
  end

  # test 'runner method runs all tests' do
  # end
end
