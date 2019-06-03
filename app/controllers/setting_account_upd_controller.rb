class SettingAccountUpdController < ApplicationController
  def post
    @message = "";
    @onePageLimit = params["one_page_limit"]
  	if @onePageLimit.blank?
  		@onePageLimit = session["one_page_limit"]
  	end
  	if @onePageLimit.blank?
  		@onePageLimit = "20"
  	end
    @onePageLimit = @onePageLimit.to_i
    @pageNum = params["page_num"].to_i
    @app_id = params['app_id'].to_i
    if params['app_id'] == '${param.app_id}'
      @app_id = 0
    end
    if params['app_id'].blank?
      @app_id = params['app_id'].to_i #debug
    end
    session[:app_id] = @app_id.to_s

    @accountObj = Account.find(@app_id)
    @accountObj['password'] = params['app_password'] unless params['app_password'].blank?
    @accountObj['fullname'] = params['app_fullname'] unless params['app_fullname'].blank?
    @accountObj['fullname'] = params['app_fullname_furigana'] unless params['app_fullname_furigana'].blank?
    @accountObj['main_mail'] = params['app_main_mail'] unless params['app_main_mail'].blank?
    @accountObj['cc_mail_01'] = params['app_cc_mail_01'] unless params['app_cc_mail_01'].blank?
    @accountObj['cc_mail_02'] = params['app_cc_mail_02'] unless params['app_cc_mail_02'].blank?
    @accountObj['setting_00'] = params['app_setting_00'] unless params['app_setting_00'].blank?
    @accountObj['setting_01'] = params['app_setting_01'] unless params['app_setting_01'].blank?
    @accountObj['setting_02'] = params['app_setting_02'] unless params['app_setting_02'].blank?
    @appPosition = params['app_position'].nil? ? 1 : params['app_position'] #debug
    @appGroup = params['app_group'].to_i
    @appStore = params['app_store'].to_i
    session[:accountObj] = @accountObj
    #@accountObj = params["loginAccountObj"].nil? ? session["loginAccountObj"] : params["loginAccountObj"]
    @loginAccountObj = @accountObj

    render 'setting_account_upd'
  end

end
