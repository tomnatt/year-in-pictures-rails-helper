require 'test_helper'
require 'date_service'

# Test DateService
class DateServiceTest < ActiveSupport::TestCase
  test 'last month for date in early Feb is Jan' do
    travel_to Time.new(2018, 2, 1)
    assert_equal 1, DateService.define_last_month
  end

  test 'last month for date in late Feb is Feb' do
    travel_to Time.new(2018, 2, 27)
    assert_equal 2, DateService.define_last_month
  end

  test 'last month for date in early Jan is Dec' do
    travel_to Time.new(2018, 1, 1)
    assert_equal 12, DateService.define_last_month
  end
end
