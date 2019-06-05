class SettingNotificationCreateConfController < ApplicationController
  def post
    logger.debug "debug:params=#{params.inspect}"
    render 'setting_notification_create_conf'
  end

end
