class ApplicantDisplaysController < ApplicationController
  before_action :set_applicant_display, only: [:show, :edit, :update, :destroy]

  # GET /applicant_displays
  # GET /applicant_displays.json
  def index
    @applicant_displays = ApplicantDisplay.all
  end

  # GET /applicant_displays/1
  # GET /applicant_displays/1.json
  def show
  end

  # GET /applicant_displays/new
  def new
    @applicant_display = ApplicantDisplay.new
  end

  # GET /applicant_displays/1/edit
  def edit
  end

  # POST /applicant_displays
  # POST /applicant_displays.json
  def create
    @applicant_display = ApplicantDisplay.new(applicant_display_params)

    respond_to do |format|
      if @applicant_display.save
        format.html { redirect_to @applicant_display, notice: 'Applicant display was successfully created.' }
        format.json { render :show, status: :created, location: @applicant_display }
      else
        format.html { render :new }
        format.json { render json: @applicant_display.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applicant_displays/1
  # PATCH/PUT /applicant_displays/1.json
  def update
    respond_to do |format|
      if @applicant_display.update(applicant_display_params)
        format.html { redirect_to @applicant_display, notice: 'Applicant display was successfully updated.' }
        format.json { render :show, status: :ok, location: @applicant_display }
      else
        format.html { render :edit }
        format.json { render json: @applicant_display.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicant_displays/1
  # DELETE /applicant_displays/1.json
  def destroy
    @applicant_display.destroy
    respond_to do |format|
      format.html { redirect_to applicant_displays_url, notice: 'Applicant display was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_applicant_display
      @applicant_display = ApplicantDisplay.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def applicant_display_params
      params.fetch(:applicant_display, {})
    end
end
