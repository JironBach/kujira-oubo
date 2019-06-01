require 'openssl'
require 'base64'

class LoginController < ApplicationController
  def login
    session["message"] = ''
    render 'login'
  end

  def post
    @userEmail = params["user_email"]
    @password = Common.encrypt(params["user_password"])
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

end
