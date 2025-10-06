class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    if resource.user_type == "employer"
      companies_path
    elsif resource.user_type == "seeker"
      jobs_path
    end
  end
end
