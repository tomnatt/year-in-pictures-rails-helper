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
    pictures = Picture.where(year:).to_a

    # .order(month: :asc, ).to_a
    # (books: { print_year: :desc }, authors: { name: :asc })

    # Sort by photographer
    pictures.sort_by! { |pic| pic.user.fullname }
  end
end
