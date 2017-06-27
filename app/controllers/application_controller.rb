class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #before_action :authenticate_user!

  include Pundit

  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(user)
    wikis_path
  end

  def sign_in_required
    unless current_user
      flash[:alert] = "You must be logged in to do that"
      redirect_to user_session_path
    end
  end
end
