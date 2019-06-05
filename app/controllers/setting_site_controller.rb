class SettingSiteController < ApplicationController
  def show
    @recruitmentSiteArray = RecruitmentSite.all
    @m_siteArray = MSite.where(del_flg: 0).all

    render 'setting_site'
  end

  def post
    @recruitmentSiteArray = RecruitmentSite.where(delete_flg: 0).all
    @m_site = MSite
    if !params[:searchSite].blank?
      @m_site = @m_site.where(recruitment_site_id: params[:searchSite]).where(del_flg: 0)
    end
    if !params[:searchTitle].blank?
      @m_site = @m_site.where("name LIKE ?", "%#{params[:searchTitle]}%").where(del_flg: 0)
    end
    if params[:searchSite].blank? && params[:searchTitle].blank?
      @m_siteArray = MSite.where(del_flg: 0).all
    else
      @m_siteArray = @m_site.all
    end

    render 'setting_site'
  end

end
