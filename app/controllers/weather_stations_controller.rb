class WeatherStationsController < ApplicationController
  before_action :set_weather_station, only: %i[ show edit update destroy ]

  # GET /weather_stations or /weather_stations.json
  def index
    @weather_stations = WeatherStation
                          .filter(filters_params)
                          .paginate(page: params[:page], per_page: 10)
                          .order("sg_estado ASC, cidade ASC")
  end

  # GET /weather_stations/1 or /weather_stations/1.json
  def show
  end

  # GET /weather_stations/new
  def new
    @weather_station = WeatherStation.new
  end

  # GET /weather_stations/1/edit
  def edit
  end

  # POST /weather_stations or /weather_stations.json
  def create
    @weather_station = WeatherStation.new(weather_station_params)

    respond_to do |format|
      if @weather_station.save
        format.html { redirect_to weather_station_url(@weather_station), notice: "Weather station was successfully created." }
        format.json { render :show, status: :created, location: @weather_station }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @weather_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weather_stations/1 or /weather_stations/1.json
  def update
    respond_to do |format|
      if @weather_station.update(weather_station_params)
        format.html { redirect_to weather_station_url(@weather_station), notice: "Weather station was successfully updated." }
        format.json { render :show, status: :ok, location: @weather_station }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @weather_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_stations/1 or /weather_stations/1.json
  def destroy
    @weather_station.destroy

    respond_to do |format|
      format.html { redirect_to weather_stations_url, notice: "Weather station was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather_station
      @weather_station = WeatherStation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def weather_station_params
      params.require(:weather_station).permit(:cidade, :sg_estado, :situacao, :vl_latitude, :vl_longitude, :vl_altitude, :dta_inicio_operacao, :cdg_estacao)
    end

    def filters_params
      filters = params.fetch(:filters, {}).permit(:sg_estado, :situacao, :cdg_estacao)
    end
end
