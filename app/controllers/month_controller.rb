class MonthController < ApplicationController
  def show
    @pictures = []
    month = params[:month]
    return unless month =~ /\A\d{1,2}\z/
    @pictures = Picture.where(month: month).order('photographer ASC')
  end
end
