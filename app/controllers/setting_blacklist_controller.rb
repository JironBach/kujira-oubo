class SettingBlacklistController < ApplicationController
  def show
    render 'setting_blacklist'
  end

  def post
    @blacklist = Blacklist
    if !params['bl_name'].blank?
      @blacklist = @blacklist.where("name LIKE ?", "%#{params['bl_name']}%")
      logger.debug "debug:blacklist_count=#{@blacklist.count.inspect}"
    end
    if !params['bl_mail'].blank?
      @blacklist = @blacklist.where("mail LIKE ? OR mail2 LIKE ? OR tel LIKE ? OR tel2 LIKE ?", \
        "%#{params['bl_mail']}%", "%#{params['bl_mail']}%", \
        "%#{params['bl_mail']}%", "%#{params['bl_mail']}%")
    end
    if params['bl_name'].blank? && params['bl_mail'].blank?
      @blacklist = Blacklist.all
    else
      @blacklist = @blacklist.all
    end

    render 'setting_blacklist'
  end

end
