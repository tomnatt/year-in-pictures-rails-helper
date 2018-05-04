class MonthController < ApplicationController
  before_action :check_admin

  def show
    @pictures = []
    month = params[:month]
    return unless month =~ /\A\d{1,2}\z/
    @pictures = get_pictures(month)
  end

  private

  # Get the pics and create placeholder entries for any missing
  def get_pictures(month)
    pictures = Picture.where(month: month).to_a
    # TODO: select only active users
    User.all.each do |photographer|
      next if pictures.any? { |pic| pic.user == photographer }
      pictures << Picture.placeholder(photographer.fullname)
    end

    # Sort by photographer
    pictures.sort_by! { |pic| pic.user.fullname }
  end
end
