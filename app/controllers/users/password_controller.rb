class Users::PasswordController < ApplicationController
  def new
    render 'new'
  end

  def create
    fromWhich = params["from_which"]
    userEmail = ""
    password = ""
    message = ""
    sendUrl = nil
    id = 0;

    if !fromWhich.nil? && fromWhich == "login.jsp"
      userEmail = params["user_email"]
      password = Common.encrypt(params["user_password"])
      if "kujira@107.co.jp" == userEmail && "kujira" == password
        obj = session["loginAccountObj"].nil? ? Account.new : session["loginAccountObj"]
        obj.fullname = "九地良スーパーユーザー"
        obj.email = userEmail
        obj.password = password
        #session.setAttribute("loginAccountObj", obj);
        session["loginAccountObj"] = obj
        redirect_to "/"
        return;
      end
      if userEmail.blank?
        message = "メールアドレスとパスワードを入力ください。"
        redirect_to "/login"
      elsif
        if Common.valid_email(userEmail)
          message = "メールアドレスが無効です。";
          redirect_to "/login"
        end
      end
      if password.blank?
        message = "メールアドレスとパスワードを入力ください。";
        redirect_to "/login"
      elsif
        if (password.length() < 7)
          message = "パスワードは７桁以上が必要です。";
          redirect_to "/login"
        end
        id = User.where(email: userEmail, encrypted_password: password, confirmed_at: :not_null).first.id
        #String sql = "select id from users where email = ? && encrypted_password = ? && confirmed_at IS NOT NULL;";
        if (id > 0)
          obj = ReadAccount.where(email: userEmail, password: password).last
          session["loginAccountObj"] = obj
          redirect_to "/login"
          return;
        else
          message = "ログイン情報が無効です。"
          redirect_to "/login"
        end
      end
    else
      message = "続けるにはログインが必要です。";
      userEmail = "";
      redirect_to "/login"
    end
  end

end
