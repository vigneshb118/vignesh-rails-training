class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    jobs_path
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to jobs_path
  end
end
