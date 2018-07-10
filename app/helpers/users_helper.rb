module UsersHelper
  def oauth_content(provider, signup_or_login)
    case provider
    when :twitter
      button_color = 'info'
    when :facebook
      button_color = 'link'
    when :google_oauth2
      button_color = 'danger'
      provider_name = 'google'
    end

    content_tag(:div, '', class: 'field') do
      link_to omniauth_authorize_path(resource_name, provider),
        class: "button is-block is-#{button_color} is-medium is-fullwidth has-text-left" do
        concat(
          content_tag(:span, '', class: 'icon') do
            content_tag(:i, '', class: "fab fa-#{provider_name || provider}")
          end
        )
        concat(
          content_tag(:span, "#{provider_name&.camelize || OmniAuth::Utils.camelize(provider)}アカウントで#{signup_or_login == :signup ? '登録' : 'ログイン'}")
        )
      end
    end
  end
end
