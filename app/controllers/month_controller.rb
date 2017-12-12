class MonthController < ApplicationController
  def show
    @pictures = []
    month = params[:month]
    return unless month =~ /\A\d{1,2}\z/

    # Get the pics and create placeholder entries for any missing
    @pictures = Picture.where(month: month).to_a
    Picture.photographers.each do |photographer|
      next if @pictures.any? { |pic| pic.photographer == photographer }
      @pictures << Picture.placeholder(photographer)
    end

    # Sort by photographer
    @pictures.sort_by!(&:photographer)
  end
end
