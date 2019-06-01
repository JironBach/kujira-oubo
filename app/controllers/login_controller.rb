class LoginController < ApplicationController
  def new
    render 'new'
  end

  #POST /resource/sign_in
  def create
    @userEmail = params["email"]
    @password = Common.encrypt(params["password"])
    @fromWhich = params["from_which"]
    @message = session["message"]
    account = Account.where(delete_flg: 0, main_mail: @userEmail, password: @password).first
    if "login.jsp" == @fromWhich
      if @userEmail.blank? || @password.blank?
        @message = "メールドレスとパスワードを入力してください。";
        session["message"] = @message
        session["loginAccountObj"] = nil
        render 'new'
      elsif account.nil?
        @message = "メールアドレスとパスワードが一致しません。"
        logger.debug "debug:message=#{params.inspect}"
        session["message"] = @message
        session["loginAccountObj"] = nil
        render 'new'
      else
        session["loginAccountObj"] = account
        redirect_to top_path and return
      end
    end
  end
end
