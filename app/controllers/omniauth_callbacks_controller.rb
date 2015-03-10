class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{:facebook, :spotify, :google_oauth2}
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "#{:facebook, :spotify, :google_oauth2}".capitalize) if is_navigational_format?
        else
          session["devise.#{:facebook, :spotify, :google_oauth2}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
   }

  end

  [:facebook, :spotify, :google_oauth2].each do |provider|
    provides_callback_for provider
  end

  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      finish_signup_path(resource)
    end
  end
end
