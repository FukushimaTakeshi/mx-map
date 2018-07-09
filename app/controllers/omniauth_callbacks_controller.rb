class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    callback_from :twitter
  end

  private

  def callback_from(provider)
    @user = User.find_for_oauth(request.env["omniauth.auth"].except("extra"))

    if @user.persisted?
      flash[:notice] = "#{provider}でのログインが完了しました。"
      sign_in_and_redirect @user
    else
      # session["devise.#{provider}_data"] = request.env['omniauth.auth']
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end
end
