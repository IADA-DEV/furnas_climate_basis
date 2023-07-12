class InmetWeatherDataController < ApplicationController
  before_action :set_inmet_weather_datum, only: %i[ show edit update destroy ]

  # GET /inmet_weather_data or /inmet_weather_data.json
  def index
    @inmet_weather_data = InmetWeatherDatum.all
  end

  # GET /inmet_weather_data/1 or /inmet_weather_data/1.json
  def show
  end

  # GET /inmet_weather_data/new
  def new
    @inmet_weather_datum = InmetWeatherDatum.new
  end

  # GET /inmet_weather_data/1/edit
  def edit
  end

  # POST /inmet_weather_data or /inmet_weather_data.json
  def create
    @inmet_weather_datum = InmetWeatherDatum.new(inmet_weather_datum_params)

    respond_to do |format|
      if @inmet_weather_datum.save
        format.html { redirect_to inmet_weather_datum_url(@inmet_weather_datum), notice: "Inmet weather datum was successfully created." }
        format.json { render :show, status: :created, location: @inmet_weather_datum }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inmet_weather_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inmet_weather_data/1 or /inmet_weather_data/1.json
  def update
    respond_to do |format|
      if @inmet_weather_datum.update(inmet_weather_datum_params)
        format.html { redirect_to inmet_weather_datum_url(@inmet_weather_datum), notice: "Inmet weather datum was successfully updated." }
        format.json { render :show, status: :ok, location: @inmet_weather_datum }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inmet_weather_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inmet_weather_data/1 or /inmet_weather_data/1.json
  def destroy
    @inmet_weather_datum.destroy

    respond_to do |format|
      format.html { redirect_to inmet_weather_data_url, notice: "Inmet weather datum was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inmet_weather_datum
      @inmet_weather_datum = InmetWeatherDatum.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inmet_weather_datum_params
      params.fetch(:inmet_weather_datum, {})
    end
end
