class NoaWeatherStationsController < ApplicationController
  before_action :set_noa_weather_station, only: %i[ show edit update destroy ]
  before_action :set_filter_index, only: %i[index]

  # GET /noa_weather_stations or /noa_weather_stations.json
  def index
    @noa_weather_stations = NoaWeatherStation
                              .filter(filters_params)
                              .paginate(page: params[:page], per_page: 20)
  end

  # GET /noa_weather_stations/1 or /noa_weather_stations/1.json
  def show
  end

  # GET /noa_weather_stations/new
  def new
    @noa_weather_station = NoaWeatherStation.new
  end

  # GET /noa_weather_stations/1/edit
  def edit
  end

  # POST /noa_weather_stations or /noa_weather_stations.json
  def create
    @noa_weather_station = NoaWeatherStation.new(noa_weather_station_params)

    respond_to do |format|
      if @noa_weather_station.save
        format.html { redirect_to noa_weather_station_url(@noa_weather_station), notice: "Noa weather station was successfully created." }
        format.json { render :show, status: :created, location: @noa_weather_station }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @noa_weather_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /noa_weather_stations/1 or /noa_weather_stations/1.json
  def update
    respond_to do |format|
      if @noa_weather_station.update(noa_weather_station_params)
        format.html { redirect_to noa_weather_station_url(@noa_weather_station), notice: "Noa weather station was successfully updated." }
        format.json { render :show, status: :ok, location: @noa_weather_station }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @noa_weather_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /noa_weather_stations/1 or /noa_weather_stations/1.json
  def destroy
    @noa_weather_station.destroy

    respond_to do |format|
      format.html { redirect_to noa_weather_stations_url, notice: "Noa weather station was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def start_import

  end

  def set_filter_index
    @station = NoaWeatherStation.all

    @wmo = @station.collect{ |t| t.cdg_estacao }.uniq
    @name = @station.collect{ |t| t.name }.uniq

    @fiters_params = filters_params
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_noa_weather_station
      @noa_weather_station = NoaWeatherStation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def noa_weather_station_params
      params.fetch(:noa_weather_station, {})
    end

    def filters_params
      params.permit( :by_name, :by_cdg_estacao )
    end
end
