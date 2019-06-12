class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all
    @recruitmentSites = RecruitmentSite.where(del_flg: 0).all

    render 'setting_site'

  end

  # GET /sites/1
  # GET /sites/1.json
  def show
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @recruitmentSiteArray = RecruitmentSite.where(del_flg: 0).all
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

    render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.fetch(:site, {})
    end
end
