class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    wikis_path
  end

  def sign_in_required
    unless current_user
      flash[:alert] = "You must be logged in to do that"
      redirect_to user_session_path
    end
  end


  private

  def user_not_authorized
    flash[:alert] = "Access Denied"
    redirect_to (request.referrer || root_path)
  end
end
