require 'content_test_service'

class YearController < ApplicationController
  skip_before_action :authenticate_user!
  before_action -> { check_token_or_admin(params[:token]) }

  def show
    @pictures = []
    year = params[:year]
    return unless year =~ /\A\d{4}\z/

    @pictures = get_pictures(year)
  end

  private

  # Get the pics for the given year and sort by month then photographer
  def get_pictures(year)
    Picture.where(year:).order(month: :asc, image: :asc).to_a
  end
end
