class MonthController < ApplicationController
  before_action :authenticate_user!

  def show
    @pictures = []
    month = params[:month]
    return unless month =~ /\A\d{1,2}\z/

    # Get the pics and create placeholder entries for any missing
    @pictures = Picture.where(month: month).to_a
    # TODO: select only active users
    User.all.each do |photographer|
      next if @pictures.any? { |pic| pic.user == photographer }
      @pictures << Picture.placeholder(photographer.fullname)
    end

    # Sort by photographer
    @pictures.sort_by!(&:photographer)
  end
end
