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
    logger.debug "debug:params=#{params.inspect}"
    @id = params['app_id'].blank? ? 6 : params['app_id'].to_i #debug

    @accountObj = Account.find(@id)
    session["accountObj"] = @accountObj
    #@accountObj = params["loginAccountObj"].nil? ? session["loginAccountObj"] : params["loginAccountObj"]
    @loginAccountObj = @accountObj

    render 'setting_account_upd'
  end

end
