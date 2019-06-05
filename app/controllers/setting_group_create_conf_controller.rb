class SettingGroupCreateConfController < ApplicationController
  def show
    logger.debug "debug:params=#{params.inspect}"
    
    render 'setting_group_create_conf'
  end

end
