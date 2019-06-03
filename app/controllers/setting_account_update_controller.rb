class SettingAccountUpdateController < ApplicationController
  def post
    logger.debug "debug:params=#{params.inspect}"
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
    @pageNumStr = params['pageNumStr']
    @app_password = params['app_password']

    if params['app_id'] == '${param.app_id}'
      @id = 0 #debug
    end
    if @id == 0
      @id = 6 #debug
    end
    @accountObj = Account.where(id: @id).last
    unless @accountObj.nil?
      @accountObj.password = Common.encrypt(params['app_password'])
      @accountObj.fullname = params['app_fullname']
      @accountObj.fullname = params['app_fullname_furigana']
      @accountObj.main_mail = params['app_main_mail']
      @accountObj.cc_mail_01 = params['app_cc_mail_01']
      @accountObj.cc_mail_02 = params['']
      @accountObj.setting_00 = params['app_setting_00']
      @accountObj.setting_01 = params['app_setting_01']
      @accountObj.setting_02 = params['app_setting_02']
      @accountObj.position = params['app_position'].nil? ? 1 : params['app_position'] #debug
      @accountObj.s_group = params['app_group'].to_i
      @accountObj.store = params['app_store'].to_i
      #@accountObj = params["loginAccountObj"].nil? ? session["loginAccountObj"] : params["loginAccountObj"]
      @loginAccountObj = @accountObj

      @accountObj.save!
    end
    redirect_to '/setting_account'
  end
end
