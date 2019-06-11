# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    @message = '続けるにはログインが必要です。'
    super
  end

  # POST /resource/sign_in
  def create
    super
    if !user_signed_in?
      @message = 'ログイン情報が無効です。'
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:commit])
  end
end
