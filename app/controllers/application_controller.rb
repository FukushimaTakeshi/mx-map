class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
  end

  private

  def admin_user
    redirect_to root_url unless current_user.try(:admin?)
  end
  
  # https://github.com/plataformatec/devise/blob/v4.4.3/lib/devise/controllers/helpers.rb#L215
  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User)
        user_path(current_user)
      else
        super
      end
  end
end
