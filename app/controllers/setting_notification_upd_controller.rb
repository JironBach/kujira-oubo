class SettingNotificationUpdController < ApplicationController
  def post
    logger.debug "debug:params=#{params.inspect}"
    render 'setting_notification_upd'
  end

end
