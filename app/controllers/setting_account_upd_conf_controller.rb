class SettingAccountUpdConfController < ApplicationController
  def post
    @message = "";
    @onePageLimit = params["one_page_limit"]
  	if @onePageLimit.blank?
  		@onePageLimit = session[:one_page_limit]
  	end
  	if @onePageLimit.blank?
  		@onePageLimit = "20"
  	end
    @onePageLimit = @onePageLimit.to_i
    @pageNum = params["page_num"].to_i
    @pageNumStr = params['pageNumStr']
    @app_password = params['app_password']

    unless session[:app_id].nil?
      if params['app_id'] == '${param.app_id}'
        @id = 0 #debug
      end
      if @id == 0
        @id = 7 #debug
      end
    end
    session[:app_id] = @id unless session[:app_id].nil?

    @accountObj = session[:accountObj]
    @accountObj['password'] = params['app_password'] unless params['app_password'].blank?
    @accountObj['fullname'] = params['app_fullname'] unless params['app_fullname'].blank?
    @accountObj['fullname_furigana'] = params['app_fullname_furigana'] unless params['app_fullname_furigana'].blank?
    @accountObj['main_mail'] = params['app_main_mail'] unless params['app_main_mail'].blank?
    @accountObj['cc_mail_01'] = params['app_cc_mail_01'] unless params['app_cc_mail_01'].blank?
    @accountObj['cc_mail_02'] = params['cc_mail_02'] unless params['cc_mail_02'].blank?
    @accountObj['setting_00'] = params['app_setting_00'] unless params['app_setting_00'].blank?
    @accountObj['setting_01'] = params['app_setting_01'] unless params['app_setting_01'].blank?
    @accountObj['setting_02'] = params['app_setting_02'] unless params['app_setting_02'].blank?
    @appPosition = params['app_position'].nil? ? 1 : params['app_position'] #debug
    @appGroup = params['app_group'].to_i
    @appStore = params['app_store'].to_i

    logger.debug "session[:app_id]=#{session[:app_id]}"
    unless session[:app_id].blank?
      accountObj = Account.where(id: session[:app_id].to_i).first
      accountObj.password = Common.encrypt(params['app_password']) unless params['app_password'].blank?
      accountObj.fullname = params['app_fullname'] unless params['app_fullname'].blank?
      accountObj.fullname_furigana = params['app_fullname_furigana'] unless params['app_fullname_furigana'].blank?
      accountObj.main_mail = params['app_main_mail'] unless params['app_main_mail'].blank?
      accountObj.cc_mail_01 = params['app_cc_mail_01'] unless params['app_cc_mail_01'].blank?
      accountObj.cc_mail_02 = params['cc_mail_02'] unless params['cc_mail_02'].blank?
      accountObj.setting_00 = params['app_setting_00'] unless params['app_setting_00'].blank?
      accountObj.setting_01 = params['app_setting_01'] unless params['app_setting_01'].blank?
      accountObj.setting_02 = params['app_setting_02'] unless params['app_setting_02'].blank?
      accountObj.position = params['app_position'].nil? ? 1 : params['app_position'] #debug
      accountObj.s_group = params['app_group'].to_i
      accountObj.store = params['app_store'].to_i
      accountObj.save!
    end

    #@accountObj = params["loginAccountObj"].nil? ? session["loginAccountObj"] : params["loginAccountObj"]
    @loginAccountObj = @accountObj

    if !session[:app_id].blank?
      render 'setting_account_upd_conf'
    else
      session[:app_id] = nil
      redirect_to '/setting_account'
    end
  end

end
