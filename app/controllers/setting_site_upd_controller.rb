class SettingSiteUpdController < ApplicationController
  def post
    session['app_id'] = params['app_id'] if params['app_id'] =~ /^[0-9]+$/

    message = ""
    onePageLimit = params["one_page_limit"]
    onePageLimit = session["one_page_limit"].to_s unless onePageLimit.nil?
    onePageLimit = "20" unless onePageLimit.blank?
    pageNum = params["page_num"]
    app_id = params["app_id"]

    @recruitmentSiteArray = RecruitmentSite.where(del_flg: 0).all
    @m_site = MSite.where(id: app_id.to_i).last
    @m_site.user_id = ''
    @m_site.extra1 = ''
    @m_site.extra2 = ''
    @m_site.extra3 = ''
    @m_site.enterprise_cnt = 0
    #@m_site.name = params['app_job_offer_name']
    @m_site.password = params['app_password']
    @m_site.recruitment_site_id = @recruitmentSite.id unless @recruitmentSite.nil?
    @m_site.url = @recruitmentSite.url unless @recruitmentSite.nil?
    @m_site.no_scraping_flg = params['no_scraping_flg'].to_i
    @app_no_scraping_txt = params['app_no_scraping_txt']
    @recruitmentSite = RecruitmentSite.where(id: @m_site.recruitment_site_id.to_i).first
    #@m_site.save!

    render 'setting_site_upd'
  end

end
