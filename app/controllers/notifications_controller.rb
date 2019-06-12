class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  # GET /notifications
  # GET /notifications.json
  def index
    logger.debug "debug:params=#{params.inspect}"

    if params['one_page_limit'].blank?
      per = params['per'].blank? ? 20 : params['per']
    else
      per = params['one_page_limit']
    end
    @per = per
    @notifications = Notification.where(delete_flg: 0).order(id: 'desc').page(params[:page]).per(per).all
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    @notification = Notification.find(params[:id])
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
    @notification = Notification.find(params[:id].to_i)
  end

  # POST /notifications
  # POST /notifications.json
  def create
    if params['one_page_limit'].blank?
      @notification = Notification.new(notification_params)

      respond_to do |format|
        if @notification.save
          format.html { redirect_to notifications_path }
          format.json { render :index, status: :created, location: @notification }
        else
          format.html { render :index and return}
          format.json { render json: @notification.errors, status: :unprocessable_entity }
        end
      end
    else
      if params['one_page_limit'].blank?
        per = params['per'].blank? ? 20 : params['per']
      else
        per = params['one_page_limit'].blank? ? 20 : params['one_page_limit']
      end
      @per = per
      redirect_to action: 'index', per: per and return
    end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { render :index, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification = Notification.find(params[:id].to_i)
    @notification.delete_flg = 1
    @notification.save!

    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def conf
    @notification = Notification.new
  end

  def set_page_limit
    if params['one_page_limit'].blank?
      per = params['per'].blank? ? 20 : params['per']
    else
      per = params['one_page_limit'].blank? ? 20 : params['one_page_limit']
    end
    @per = per
    @notifications = Notification.where(delete_flg: 0).order(id: 'desc').page(params[:page]).per(per).all

    redirect_to action: 'index', per: per
  end

  def batch_del
    logger.debug "debug:params=#{params.inspect}"

    params['batch_del'].each do |i|
      @notification = Notification.find(i)
      @notification.delete_flg = 1
      @notification.save!
    end

    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'S group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.new()
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:start_date, :end_date, :title, :purpose)
    end
end
