# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  private
  def respond_with(resource, _opts = {})
  render json: {
    message: 'You are logged in.',
    user: current_user
    }, status: :ok
  end

  def respond_to_on_destroy
    log_out_success && return if current_user
    log_out_failure
  end
  def log_out_success
    render json: { message: "You are logged out." }, status: :ok
  end
  def log_out_failure
    render json: { message: "Hmm nothing happened."}, status: :unauthorized
  end

  # before_action :configure_sign_in_params, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  #   if params[:user][:email] =~ /deleted_user\d+@admin.ru/
  #     sign_out(current_user)
  #   end
  # end

  def check_email
    if current_user.email =~ /deleted_user\d+@admin.ru/
      sign_out(current_user)
      respond_to do |format|
        format.json { render json: { status: "Ваш аккаунт удалён." } }
        format.html
      end
    end
  end

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
