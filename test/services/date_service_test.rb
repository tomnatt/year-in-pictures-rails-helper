require 'test_helper'
require 'date_service'

# Test DateService
class DateServiceTest < ActiveSupport::TestCase
  test 'last month for date in early Feb is Jan' do
    travel_to Time.new(2018, 2, 1).in_time_zone
    assert_equal 1, DateService.define_last_month
  end

  test 'last month for date in late Feb is Feb' do
    travel_to Time.new(2018, 2, 27).in_time_zone
    assert_equal 2, DateService.define_last_month
  end

  test 'last month for date in early Jan is Dec' do
    travel_to Time.new(2018, 1, 1).in_time_zone
    assert_equal 12, DateService.define_last_month
  end

  test 'year for last month is 2018 late in May 2018' do
    travel_to Time.new(2018, 5, 25).in_time_zone
    assert_equal 2018, DateService.year_for_last_month
  end

  test 'year for last month is 2018 late in Jan 2018' do
    travel_to Time.new(2018, 1, 25).in_time_zone
    assert_equal 2018, DateService.year_for_last_month
  end

  test 'year for last month is 2017 early in Jan 2018' do
    travel_to Time.new(2018, 1, 3).in_time_zone
    assert_equal 2017, DateService.year_for_last_month
  end

  test 'year for last month is 2017 late in Dec 2017' do
    travel_to Time.new(2017, 12, 25).in_time_zone
    assert_equal 2017, DateService.year_for_last_month
  end

  test 'month and year when incrementing last month from late May 2018' do
    travel_to Time.new(2018, 5, 25).in_time_zone
    month, year = DateService.increment_last_month
    assert_equal 6, month, 'Month should be June'
    assert_equal 2018, year, 'Year should be 2018'
  end

  test 'month and year when incrementing last month from early May 2018' do
    travel_to Time.new(2018, 5, 5).in_time_zone
    month, year = DateService.increment_last_month
    assert_equal 5, month, 'Month should be May'
    assert_equal 2018, year, 'Year should be 2018'
  end

  test 'month and year when incrementing last month in early Jan 2018' do
    travel_to Time.new(2018, 1, 5).in_time_zone
    month, year = DateService.increment_last_month
    assert_equal 1, month, 'Month should be January'
    assert_equal 2018, year, 'Year should be 2018'
  end

  test 'month and year when incrementing last month in late Dec 2017' do
    travel_to Time.new(2017, 12, 25).in_time_zone
    month, year = DateService.increment_last_month
    assert_equal 1, month, 'Month should be January'
    assert_equal 2018, year, 'Year should be 2018'
  end
end
