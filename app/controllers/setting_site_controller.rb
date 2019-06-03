class SettingSiteController < ApplicationController
  def show
    @recruitmentSiteArray = RecruitmentSite.all
    @siteArray = RecruitmentSite.all

    render 'setting_site'
  end

end
