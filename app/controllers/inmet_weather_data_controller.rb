class InmetWeatherDataController < ApplicationController
  before_action :set_inmet_weather_datum, only: %i[ show edit update destroy ]
  before_action :set_filter_index, only: %i[index]

  # GET /inmet_weather_data or /inmet_weather_data.json
  def index
    @inmet_weather_data = InmetWeatherDatum
                            .filter(filters_params)
                            .paginate(page: params[:page], per_page: 20)
                            .order(:inmet_weather_station_id, :dta_medicao, :hr_medicao)
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

  def set_filter_index
    @wmo = InmetWeatherStation.all.collect{ |t| t.cdg_estacao }.uniq

    @fiters_params = filters_params
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

    def filters_params
      filter = params.permit( :by_hr_medicao, :by_dta_medicao, :by_cdg_station)
      filter[:by_dta_medicao] = filter[:by_dta_medicao].present? ? filter[:by_dta_medicao] : Date.current.to_s
      filter[:by_cdg_station] = filter[:by_cdg_station].present? ? filter[:by_cdg_station] : 'A002'
      return filter
    end

end
