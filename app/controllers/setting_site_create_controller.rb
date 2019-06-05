class SettingSiteCreateController < ApplicationController
  def show
    @recruitmentSiteArray = RecruitmentSite.where(del_flg: 0).all

    render 'setting_site_create'
  end

end
