class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    callback_from :twitter
  end

  private

  def callback_from(provider)
    @user = User.find_for_oauth(request.env["omniauth.auth"].except("extra"))

    if @user.persisted?
      flash[:notice] = "#{provider}でのログインが完了しました。"
      sign_in_and_redirect @user #, event: :authentication
      # set_flash_message(:notice, :success, kind: provider_id.capitalize) if is_navigational_format?
    else
      # session["devise.#{provider}_data"] = request.env['omniauth.auth']
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
      flash[:notice] = "#{provider}でのログインに失敗しました。"
      # set_flash_message(:notice, :"signed_up_but_#{resource.inactive_message}") if is_navigational_format?
    end
  end
end
