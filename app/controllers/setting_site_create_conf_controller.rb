class SettingSiteCreateConfController < ApplicationController
  def post
    logger.debug "debug:params=#{params.inspect}"

    @recruitmentSiteArray = RecruitmentSite.where(del_flg: 0).all

    if !params['app_site_id'].blank?
      @recruitmentSite = RecruitmentSite.where(id: params['app_site_id'].to_i).first
    end
    @m_site = MSite.new
    @m_site.name = params['app_job_offer_name']
    @m_site.password = params['app_password']
    @m_site.user_id = params['app_id']
    @m_site.recruitment_site_id = @recruitmentSite.id
    @m_site.url = @recruitmentSite.url
    @m_site.no_scraping_flg = params['no_scraping_flg'].to_i
    @app_no_scraping_txt = params['app_no_scraping_txt']

    render 'setting_site_create_conf'
  end

end
