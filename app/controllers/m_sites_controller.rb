class MSitesController < ApplicationController
  before_action :set_m_site, only: [:show, :edit, :update, :destroy]

  # GET /sites
  # GET /sites.json
  def index
    @m_sites = MSite.where(del_flg: 0).all
    @recruitment_sites = RecruitmentSite.where(del_flg: 0).all
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
  end

  # GET /sites/new
  def new
    @m_site = MSite.new
    @recruitment_sites = RecruitmentSite.where(del_flg: 0).all
  end

  # GET /sites/1/edit
  def edit
    @m_site = MSite.find(params[:id].to_i)
    @recruitment_sites = RecruitmentSite.where(del_flg: 0).all
  end

  # POST /sites
  # POST /sites.json
  def create
    logger.debug "debug_create:#{params.inspect}"
    @m_site = MSite.new #(m_site_params)
    @m_site.id = MSite.maximum(:id) + 1
    @m_site.name = params['app_job_offer_name']
    @m_site.password = params['app_password']
    @m_site.no_scraping_flg = params['app_no_scraping_flg']
    @m_site.recruitment_site_id = params['recruitment_site_id'].nil? ? '' : params['recruitment_site_id']
    @m_site.url = params['app_url']
    @m_site.user_id = params['app_user_id'].nil? ? '' : params['app_user_id']
    @m_site.extra1 = params['extra1'].nil? ? '' : params['extra1']
    @m_site.extra2 = params['extra2'].nil? ? '' : params['extra2']
    @m_site.extra3 = params['extra3'].nil? ? '' : params['extra3'].to_i
    @m_site.enterprise_cnt = params['enterprise_cnt'].nil? ? 0 : params['enterprise_cnt']
    @recruitment_sites = RecruitmentSite.all
    if (params[:app_password] != params[:app_conf_password]) &&
       !params[:app_conf_password].nil?
      @error_msg = 'パスワードが一致しません。'
    end

    @m_site.valid?
    logger.debug "debug:errors=#{@m_site.errors.full_messages.inspect}"
    logger.debug "debug:error_msg=#{@error_msg}?"
    logger.debug "debug:redirect?"
    respond_to do |format|
      if @m_site.valid? && @error_msg.blank?
        @m_site.save
        logger.debug "debug:create_redirect"
        format.html { redirect_to '/m_sites', notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @m_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    logger.debug "debug_update:params=#{params.inspect}"
    @m_site = MSite.where(id: params[:id].to_i).first
    @m_site.name = params['app_job_offer_name']
    @m_site.password = params['app_password'].nil? ? '' : params['app_password']
    @m_site.no_scraping_flg = params['app_no_scraping_flg']
    #@m_site.recruitment_site_id = params['app_site_id'].nil? ? '' :  params['app_site_id']
    @m_site.user_id = params['app_user_id'].nil? ? '' : params['app_user_id']
    @m_site.extra1 = params['extra1'].nil? ? '' : params['extra1']
    @m_site.extra2 = params['extra2'].nil? ? '' : params['extra2']
    @m_site.extra3 = params['extra3'].nil? ? '' : params['extra3'].to_i
    @m_site.enterprise_cnt = params['enterprise_cnt'].nil? ? 0 : params['enterprise_cnt']

    respond_to do |format|
      if @m_site.valid? && @error_msg.blank?
        @m_site.save
        format.html { redirect_to '/m_sites', notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @m_site }
      else
        format.html { render :edit }
        format.json { render json: @m_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    #m_@site.destroy
    m_site = MSite.find(params[:id].to_i)
    m_site.del_flg = 1
    m_site.save

    respond_to do |format|
      format.html { redirect_to '/m_sites', notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @recruitment_sites = RecruitmentSite.where(del_flg: 0).all
    @m_site = MSite
    if !params[:searchSite].blank?
      @m_site = @m_site.where(recruitment_site_id: params[:searchSite]).where(del_flg: 0)
    end
    if !params[:searchTitle].blank?
      @m_site = @m_site.where("name LIKE ?", "%#{params[:searchTitle]}%").where(del_flg: 0)
    end
    if params[:searchSite].blank? && params[:searchTitle].blank?
      @m_sites = MSite.where(del_flg: 0).all
    else
      @m_sites = @m_site.where(del_flg: 0).all
    end

    render 'index'
  end

  def conf
    logger.debug "debug_conf_update:params#{params.inspect}"
    if params[:id].nil?
      @m_site = MSite.new
      @m_site.id = MSite.maximum(:id) + 1
    else
      @m_site = MSite.where(id: params[:id].to_i).first
    end
    @m_site.name = params['app_job_offer_name']
    @m_site.password = params['app_password'].nil? ? '' : params['app_password']
    @m_site.no_scraping_flg = params['app_no_scraping_flg']
    #@m_site.recruitment_site_id = params['app_site_id'].nil? unless params['app_site_id'].blank?
    @m_site.user_id = params['app_user_id'].nil? ? '' : params['app_user_id']
    @m_site.extra1 = params['extra1'].nil? ? '' : params['extra1']
    @m_site.extra2 = params['extra2'].nil? ? '' : params['extra2']
    @m_site.extra3 = params['extra3'].nil? ? '' : params['extra3'].to_i
    @m_site.enterprise_cnt = params['enterprise_cnt'].nil? ? 0 : params['enterprise_cnt']
    @m_site.no_scraping_flg = params['cmb_no_scraping_flg'].to_i

    @recruitment_site = RecruitmentSite.where(id: @m_site.recruitment_site_id).first

    if params[:app_password].blank? || (params[:app_password] != params[:app_conf_password])
      if params[:app_password].blank?
        @error_msg = 'パスワードは必須です。'
      else
        @error_msg = 'パスワードが一致しません。'
      end
    end
    if @m_site.valid? && @error_msg.blank?
      render 'conf'
    else
      logger.debug "debug:params=#{params.inspect}"
      if params[:id].nil?
        @recruitment_sites = RecruitmentSite.all
        render 'new'
      else
        render 'edit'
      end
    end
    return
  end

  def conf_new
    logger.debug "deubg_conf_new:params#{params.inspect}"
    @m_site = MSite.new
    @m_site.id = MSite.maximum(:id) + 1
    @m_site.name = params['app_job_offer_name']
    @m_site.password = params['app_password'].nil? ? '' : params['app_password']
    @m_site.no_scraping_flg = params['app_no_scraping_flg']
    @m_site.recruitment_site_id = params['app_site_id']
    @m_site.url = params['app_url']
    @m_site.user_id = params['app_site_id'].nil? ? '' : params['app_site_id']
    @m_site.extra1 = params['extra1'].nil? ? '' : params['extra1']
    @m_site.extra2 = params['extra2'].nil? ? '' : params['extra2']
    @m_site.extra3 = params['extra3'].nil? ? '' : params['extra3'].to_i
    @m_site.enterprise_cnt = params['enterprise_cnt'].nil? ? 0 : params['enterprise_cnt']
    @m_site.no_scraping_flg = params['cmb_no_scraping_flg'].to_i

    @recruitment_site = RecruitmentSite.where(id: params['app_site_id'].to_i).first


    if params[:app_password].blank?
      @error_msg = 'パスワードは必須です。'
    elsif params[:app_password] != params[:app_conf_password]
      @error_msg = 'パスワードが一致しません。'
    else
      @error_msg = nil
    end
    if @m_site.valid? && @error_msg.blank?
      render 'conf_new'
    end
  end

  def batch_del
    logger.debug "debug:params_batch=#{params.inspect}"
    batch_del = params['delete_id_arr'].split(",")
    batch_del.each do |i|
      next if i.to_i == 0
      @m_site = MSite.where(id: i.to_i).first
      @m_site.del_flg = 1
      @m_site.save
    end

    respond_to do |format|
      format.html { redirect_to m_sites_url, notice: 'M Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_m_site
      #@m_site = MSite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def m_site_params
      #params.fetch(:m_site, {})
    end
end
