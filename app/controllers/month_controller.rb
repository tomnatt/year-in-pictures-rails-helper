class MonthController < ApplicationController
  def show
    # TODO: Add some sanitization here
    month = params[:month]
    @pictures = Picture.where(month: month).order('photographer ASC')
  end
end
