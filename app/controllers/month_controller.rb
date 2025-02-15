require 'content_test_service'

class MonthController < ApplicationController
  before_action :check_admin

  def show
    @pictures = []
    month = params[:month]
    year = get_year(params[:year])
    return unless month =~ /\A\d{1,2}\z/

    @pictures = get_pictures(month, year)
  end

  def test_month_content
    @test_results = {}
    month = params[:month]
    year = get_year(params[:year])
    return unless month =~ /\A\d{1,2}\z/

    # for each picture run all tests
    # { 'Photographer' => { 'test 1' => true, 'test 2' => false } }

    pictures = get_pictures(month, year)
    pictures.each do |picture|
      @test_results[picture.user] = ContentTestService.run_tests(picture)
    end
  end

  private

  # Get the pics for the given year and sort by photographer
  def get_pictures(month, year)
    pictures = Picture.where(month:, year:).to_a
    pictures = pictures.reject { |pic| pic.user.disabled? }

    # Sort by photographer
    pictures.sort_by! { |pic| pic.user.fullname }
  end

  # Sanitize input year or return this year
  def get_year(input_year)
    current_year = Time.now.in_time_zone.year
    return input_year if input_year.to_i.in?((2018..current_year).to_a)

    current_year
  end
end
