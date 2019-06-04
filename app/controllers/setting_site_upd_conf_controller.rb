class SettingSiteUpdConfController < ApplicationController
  def post
    session['app_id'] = params['app_id'] if params['app_id'] =~ /^[0-9]+$/

    logger.debug "debug:params=#{params.inspect}"
    logger.debug "debug:session['app_id']=#{session['app_id'].inspect}"
    unless session['app_id'].nil?
      @m_site = MSite.where(id: session['app_id'].to_i).first
      @m_site.recruitment_site_id = params['app_site_id']
      #@m_site.name = params['app_site_name'] #debug
      @m_site.name = params['app_job_offer_name']
      @m_site.user_id = params['app_user_id'].to_i
      @m_site.password = params['app_password']
      @m_site.extra1 = params['app_extra1']
      @m_site.extra2 = params['app_extra1']
      @m_site.extra3 = params['app_extra3']
      @m_site.url = params["app_url"]
      @m_site.enterprise_cnt = params["app_enterprise_cnt"]
      @m_site.no_scraping_flg = params["app_no_scraping_flg"]
      @m_site.order_key = params["app_order_key"]
      @m_site.scraping_id = params["app_scraping_id"]
      @m_site.save!
      session['app_id'] = nil
    end

    redirect_to '/setting_site'
  end

end
