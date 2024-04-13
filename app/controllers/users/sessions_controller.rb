# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # skip_before_action :verify_authenticity_token
  respond_to :json


  def create
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password])
      # Log in the user
      # session[:user_id] = user.id
      # sign_in user
      render json: { message: 'Logged in successfully', user: user }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    # session[:user_id] = nil
    render json: { message: 'Logged out successfully' }, status: :ok
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
