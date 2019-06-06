class BlacklistAddController < ApplicationController
  def post
    logger.debug "debug:params=#{params.inspect}"
    black = Blacklist.new
    black.name = params['name_blacklist']
    black.mail = params["mail_blacklist"]
    black.mail2 = params["mail2_blacklist"]
    black.tel = params["tel_blacklist"]
    black.tel2 = params["tel2_blacklist"]
    black.save!
    
    redirect_to '/setting_blacklist'
  end

end
