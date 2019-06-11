class SGroupsController < ApplicationController
  before_action :set_s_group, only: [:show, :edit, :update, :destroy]

  # GET /s_groups
  # GET /s_groups.json
  def index
    @sidebar_collapse = cookies['sidebar_collapse']
    per = params['per'].blank? ? 20 : params['per']
    @s_groups = SGroup.where(delete_flg: 0).page(params[:page]).per(per).all.order(id: "DESC")
    @accounts = Account.where(delete_flg: 0).all
  end

  # GET /s_groups/1
  # GET /s_groups/1.json
  def show
    redirect_to '/s_groups'
  end

  # GET /s_groups/new
  def new
    @sidebar_collapse = cookies['sidebar_collapse']
    @s_group = SGroup.new
    per = params['per'].blank? ? 20 : params['per']
    @s_groups = SGroup.where(delete_flg: 0).page(params[:page]).per(per).all.order(id: "DESC")
    @accounts = Account.where(delete_flg: 0).all
    @areas = Area.where(delete_flg: 0).all
  end

  # GET /s_groups/1/edit
  def edit
    @sidebar_collapse = cookies['sidebar_collapse']
    @s_group = SGroup.find(params[:id])
    per = params['per'].blank? ? 20 : params['per']
    @s_groups = SGroup.where(delete_flg: 0).page(params[:page]).per(per).all.order(id: "DESC")
    @accounts = Account.where(delete_flg: 0).all
    @areas = Area.where(delete_flg: 0).all
  end

  # POST /s_groups
  # POST /s_groups.json
  def create
    @s_group = SGroup.new(s_group_params)

    respond_to do |format|
      if @s_group.save
        format.html { redirect_to @s_group, notice: 'S group was successfully created.' }
        format.json { render :show, status: :created, location: @s_group }
      else
        format.html { render :new }
        format.json { render json: @s_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /s_groups/1
  # PATCH/PUT /s_groups/1.json
  def update
    respond_to do |format|
      if @s_group.update(s_group_params)
        #format.html { redirect_to @s_group, notice: 'S group was successfully updated.' }
        format.html { redirect_to '/s_groups' }
        format.json { render :show, status: :ok, location: @s_group }
      else
        format.html { render :edit }
        format.json { render json: @s_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /s_groups/1
  # DELETE /s_groups/1.json
  def destroy
    #@s_group.destroy
    @s_group = SGroup.find(params[:id].to_i)
    @s_group.delete_flg = 1
    @s_group.save!

    respond_to do |format|
      format.html { redirect_to s_groups_url, notice: 'S group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    per = params['per'].blank? ? 20 : params['per']
    @sidebar_collapse = cookies['sidebar_collapse']

    @s_groups = SGroup
    if !params[:name].blank?
      @s_groups = @s_groups.ransack(delete_flg: 0, name_cont: params[:name]).result
    end
    if params[:manager] != '選択してください。'
      @s_groups = @s_groups.ransack(delete_flg: 0, manager_cont: params[:manager]).result
    end
    if params[:name].blank? && (params[:manager] == '選択してください。')
      @s_groups = SGroup.where(delete_flg: 0).page(params[:page]).per(per).all.order(id: "DESC")
      session[:search] = false
    else
      @s_groups = @s_groups.where(delete_flg: 0).page(params[:page]).per(per).all.order(id: "DESC")
    end

    @accounts = Account.where(delete_flg: 0).all
    session[:search] = true

    render 'index'
  end

  def batch_del
    params['batch_del'].each do |i|
      @s_group = SGroup.find(i)
      @s_group.delete_flg = 1
      @s_group.save!
    end

    respond_to do |format|
      format.html { redirect_to s_groups_url, notice: 'S group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_s_group
      @s_group = SGroup.where(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def s_group_params
      params.require(:s_group).permit(:name, :manager, :admin_comment)
    end
end
