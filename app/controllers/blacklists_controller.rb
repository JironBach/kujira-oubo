class BlacklistsController < ApplicationController
  before_action :set_blacklist, only: [:show, :edit, :update, :destroy]

  # GET /blacklists
  # GET /blacklists.json
  def index
    if params['one_page_limit'].blank?
      per = params['per'].blank? ? 20 : params['per']
    else
      per = params['one_page_limit']
    end
    @per = per.to_i
    session['one_page_limit'] = per
    @blacklists = Blacklist.order(id: 'desc').page(params[:page]).per(per).all
  end

  # GET /blacklists/1
  # GET /blacklists/1.json
  def show
    @blacklists = Blacklist
    if !params['bl_name'].blank?
      @blacklists = @blacklist.where("name LIKE ?", "%#{params['bl_name']}%")
    end
    if !params['bl_mail'].blank?
      @blacklists = @blacklist.where("mail LIKE ? OR mail2 LIKE ? OR tel LIKE ? OR tel2 LIKE ?", \
        "%#{params['bl_mail']}%", "%#{params['bl_mail']}%", \
        "%#{params['bl_mail']}%", "%#{params['bl_mail']}%")
    end
    if params['one_page_limit'].blank?
      per = params['per'].blank? ? 20 : params['per']
    else
      per = params['one_page_limit']
    end
    @per = per.to_i
    session['one_page_limit'] = per
    if params['bl_name'].blank? && params['bl_mail'].blank?
      @blacklists = Blacklist.order(id: 'desc').page(params[:page]).per(per).all
    else
      @blacklists = @blacklist.order(id: 'desc').page(params[:page]).per(per).all
    end

    redirect_to '/blacklists'
  end

  # GET /blacklists/new
  def new
    @blacklist = Blacklist.new
  end

  # GET /blacklists/1/edit
  def edit
  end

  # POST /blacklists
  # POST /blacklists.json
  def create
    @blacklist = Blacklist.new()
    @blacklist.name = params[:name]
    @blacklist.tel = params[:tel]
    @blacklist.tel2 = params[:tel2]
    @blacklist.mail = params[:mail]
    @blacklist.mail2 = params[:mail2]

    respond_to do |format|
      if @blacklist.save
        format.html { redirect_to @blacklist, notice: 'Blacklist was successfully created.' }
        format.json { render :show, status: :created, location: @blacklist }
      else
        format.html { render :new }
        format.json { render json: @blacklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blacklists/1
  # PATCH/PUT /blacklists/1.json
  def update
    respond_to do |format|
      if @blacklist.update(blacklist_params)
        format.html { redirect_to @blacklist, notice: 'Blacklist was successfully updated.' }
        format.json { render :show, status: :ok, location: @blacklist }
      else
        format.html { render :edit }
        format.json { render json: @blacklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blacklists/1
  # DELETE /blacklists/1.json
  def destroy
    @blacklist = Blacklist.where(id: params[:id].to_i).first
    @blacklist.destroy
    respond_to do |format|
      format.html { redirect_to blacklists_url, notice: 'Blacklist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    if params['one_page_limit'].blank?
      per = params['per'].blank? ? 20 : params['per']
    else
      per = params['one_page_limit']
    end
    @per = per.to_i
    session['one_page_limit'] = per

    blacklists = Blacklist
    if !params['bl_name'].blank?
      blacklists = blacklists.where("name LIKE ?", "%#{params['bl_name']}%")
    end
    if !params['bl_mail'].blank?
      blacklists = blacklists.where("mail LIKE ? OR mail2 LIKE ? OR tel LIKE ? OR tel2 LIKE ?", \
        "%#{params['bl_mail']}%", "%#{params['bl_mail']}%", \
        "%#{params['bl_mail']}%", "%#{params['bl_mail']}%")
    end
    if params['bl_name'].blank? && params['bl_mail'].blank?
      blacklists = Blacklist.order(id: 'desc').page(params[:page]).per(per)
    else
      blacklists = blacklists.order(id: 'desc').page(params[:page]).per(per)
    end
    @blacklists = blacklists.all

    render 'index'
  end

  def batch_del
    params['batch_del'].each do |i|
      @blacklist = Blacklist.find(i.to_i)
      @blacklist.destroy
    end

    respond_to do |format|
      format.html { redirect_to blacklists_url, notice: 'S group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blacklist
      #@blacklist = Blacklist.find(params[:id].to_i)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blacklist_params
      #params.require(:blacklist).permit(:name, :tel, :tel2, :mail, :mail2)
    end
end
