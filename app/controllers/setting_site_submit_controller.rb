class SettingSiteSubmitController < ApplicationController
  def post
    @recruitmentSiteArray = RecruitmentSite.where(del_flg: 0).all
    if !params['app_site_id'].blank?
      @recruitmentSite = RecruitmentSite.where(id: params['app_site_id']).first
    end
    @m_site = MSite.new
    max = MSite.maximum(:id)
    if max.nil?
      @m_site.id = 1.to_s
    else
      @m_site.id = (max + 1).to_s
    end
    @m_site.user_id = ''
    @m_site.extra1 = ''
    @m_site.extra2 = ''
    @m_site.extra3 = ''
    @m_site.enterprise_cnt = 0
    @m_site.name = params['app_job_offer_name']
    @m_site.password = params['app_password']
    @m_site.recruitment_site_id = @recruitmentSite.id
    @m_site.url = @recruitmentSite.url
    @m_site.no_scraping_flg = params['no_scraping_flg'].to_i
    @app_no_scraping_txt = params['app_no_scraping_txt']
    @m_site.save!

    redirect_to '/setting_site'
  end

end
