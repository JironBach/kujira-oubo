class SettingAccountCreateConfController < ApplicationController
  def post
    logger.debug "debug:params=#{params.inspect}"
    render 'setting_account_create_conf'
  end

end
