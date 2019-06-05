class SettingGroupUpdController < ApplicationController
  def post
    logger.debug "debug:params=#{params.inspect}"
    
    render 'setting_group_upd'
  end

end
