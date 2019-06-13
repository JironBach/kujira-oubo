class AppStatusesController < ApplicationController
  before_action :set_app_status, only: [:show, :edit, :update, :destroy]

  # GET /app_statuses
  # GET /app_statuses.json
  def index
    @app_statuses = AppStatus.where(delete_flg: 0).all
  end

  # GET /app_statuses/1
  # GET /app_statuses/1.json
  def show
  end

  # GET /app_statuses/new
  def new
    @app_status = AppStatus.new
  end

  # GET /app_statuses/1/edit
  def edit
    @app_status = AppStatus.find(params['id'].to_i)
  end

  # POST /app_statuses
  # POST /app_statuses.json
  def create
    @app_status = AppStatus.new()
    @app_status.status_name = params[:status_name]
    @app_status.follow_up = params[:follow_up].to_i

    respond_to do |format|
      if @app_status.save
        format.html { redirect_to app_statuses_url, notice: 'App status was successfully created.' }
        format.json { render json: @app_status, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @app_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_statuses/1
  # PATCH/PUT /app_statuses/1.json
  def update
    logger.debug "debug:params=#{params.inspect}"
    @app_status = AppStatus.find(params[:id].to_i)
    @app_status.status_name = params[:status_name]
    @app_status.follow_up = params[:follow_up].to_i

    respond_to do |format|
      if @app_status.update(app_status_params)
        format.html { redirect_to app_statuses_url, notice: 'App status was successfully updated.' }
        format.json { render :show, status: :ok, location: @app_status }
      else
        format.html { render :edit }
        format.json { render json: @app_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_statuses/1
  # DELETE /app_statuses/1.json
  def destroy
    @app_status = AppStatus.find(params[:id].to_i)
    @app_status.delete_flg = 1
    @app_status.save
    respond_to do |format|
      format.html { redirect_to app_statuses_url, notice: 'App status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_status
      @app_status = AppStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_status_params
      params.fetch(:app_status, {})
    end
end
