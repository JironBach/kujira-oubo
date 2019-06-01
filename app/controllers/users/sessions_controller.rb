frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  #GET /resource/sign_in
  def new
    super
  end

  #POST /resource/sign_in
  def create
    #super
    @userEmail = params["email"]
    #@password = Common.encrypt(params["password"])
    @password = params["password"]
    @fromWhich = params["from_which"]
    @message = session["message"]
    account = Account.where(delete_flg: 0, main_mail: @userEmail, password: @password).first
    if "login.jsp" == @fromWhich
      if @userEmail.blank? || @password.blank?
        @message = "メールドレスとパスワードを入力してください。";
        session["message"] = @message
        session["loginAccountObj"] = nil
        render 'login' and return
      elsif account.nil?
        @message = "メールアドレスとパスワードが一致しません。"
        logger.debug "debug:message=#{params.inspect}"
        session["message"] = @message
        session["loginAccountObj"] = nil
        render 'login'
        return
      else
        session["loginAccountObj"] = account
        redirect_to "/" and return
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
