class SettingSiteController < ApplicationController
  def show
    @recruitmentSiteArray = RecruitmentSite.all
    @m_siteArray = MSite.all

    render 'setting_site'
  end

  def post
    logger.debug "debug:params=#{params.inspect}"

    @recruitmentSiteArray = RecruitmentSite.all
    @m_site = MSite
    if !params[:searchSite].blank?
      @m_site = @m_site.where(recruitment_site_id: params[:searchSite])
    end
    if !params[:searchTitle].blank?
      @m_site = @m_site.where("name LIKE ?", "%#{params[:searchTitle]}%")
    end
    if params[:searchSite].blank? && params[:searchTitle].blank?
      @m_siteArray = MSite.all
    else
      @m_siteArray = @m_site.all
    end

    render 'setting_site'
  end

end
