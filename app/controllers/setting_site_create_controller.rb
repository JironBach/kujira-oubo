class SettingSiteCreateController < ApplicationController
  def show
    @recruitmentSiteArray = RecruitmentSite.all

    render 'setting_site_create'
  end

end
