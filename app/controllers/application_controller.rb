class ApplicationController < ActionController::API
  # before_action :configure_devise_params, if: :devise_controller?
  def encode_token(payload)
    JWT.encode(payload, 'secret')
  end

  # def configure_devise_params
  #   devise_parameter_sanitizer.permit(:sign_up) do |patient|
  #     patient.permit(:name, :email, :password, :password_confirmation)
  #   end
  # end
end
