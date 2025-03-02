class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

  def check_admin
    return if current_user.admin?

    redirect_to root_url
  end

  def check_token_or_admin(token)
    return if token == Rails.configuration.x.token.year || (user_signed_in? && current_user.admin?)

    redirect_to root_url
  end
end
