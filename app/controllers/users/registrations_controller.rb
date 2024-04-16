# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]


  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      render json: { message: "User created successfully", user: resource, status: :created }
    else
      render json: { error: "User could not be created", errors: resource.errors }, status: :unprocessable_entity
    end
  end

  def google_signup
    user = params[:user]

    puts "details #{user}"

    @user = User.find_or_initialize_by(email: user[:email])
    if @user.new_record?
      @user.profile_picture = user[:photoURL]
      @user.first_name = user[:firstName]
      @user.last_name = user[:lastName]

      if @user.save(validate: false)
        render json: { user: @user }, status: :created
      else
        render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'User already exists', user: @user }, status: :conflict
    end

  end


  private

  def sign_up_params
    params.require(:user).permit(:email, :password)
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
