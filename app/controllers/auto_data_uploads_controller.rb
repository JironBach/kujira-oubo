class AutoDataUploadsController < ApplicationController
  before_action :set_auto_data_upload, only: [:show, :edit, :update, :destroy]

  # GET /auto_data_uploads
  # GET /auto_data_uploads.json
  def index
    @auto_data_uploads = AutoDataUpload.all
  end

  # GET /auto_data_uploads/1
  # GET /auto_data_uploads/1.json
  def show
  end

  # GET /auto_data_uploads/new
  def new
    @auto_data_upload = AutoDataUpload.new
  end

  # GET /auto_data_uploads/1/edit
  def edit
  end

  # POST /auto_data_uploads
  # POST /auto_data_uploads.json
  def create
    @auto_data_upload = AutoDataUpload.new(auto_data_upload_params)

    respond_to do |format|
      if @auto_data_upload.save
        format.html { redirect_to @auto_data_upload, notice: 'Auto data upload was successfully created.' }
        format.json { render :show, status: :created, location: @auto_data_upload }
      else
        format.html { render :new }
        format.json { render json: @auto_data_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auto_data_uploads/1
  # PATCH/PUT /auto_data_uploads/1.json
  def update
    respond_to do |format|
      if @auto_data_upload.update(auto_data_upload_params)
        format.html { redirect_to @auto_data_upload, notice: 'Auto data upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @auto_data_upload }
      else
        format.html { render :edit }
        format.json { render json: @auto_data_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auto_data_uploads/1
  # DELETE /auto_data_uploads/1.json
  def destroy
    @auto_data_upload.destroy
    respond_to do |format|
      format.html { redirect_to auto_data_uploads_url, notice: 'Auto data upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auto_data_upload
      @auto_data_upload = AutoDataUpload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auto_data_upload_params
      params.fetch(:auto_data_upload, {})
    end
end
