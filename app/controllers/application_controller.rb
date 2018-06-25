class ApplicationController < ActionController::Base
  private

  def admin_user
    redirect_to root_url unless current_user.try(:admin?)
  end
end
