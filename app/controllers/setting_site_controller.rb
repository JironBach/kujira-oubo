class SettingSiteController < ApplicationController
  def show
    @recruitmentSiteArray = RecruitmentSite.all
    @m_siteArray = MSite.all

    render 'setting_site'
  end

end
