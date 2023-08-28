class DashboardController < ApplicationController
  before_action :default_filter, only: [:index]
  before_action :default_date

  def index
    respond_to do |format|
      if @type_data
        daily_today
      else
        data_range
      end

      if turbo_frame_request?
        format.html { render partial: 'data_menu'}
      else
        format.html
      end
    end

  end

  def grafico
  end

  private

  def daily_today
    @inmet_weather_data = fetch_inmet_weather_data

    @tem_ins = fetch_and_process_data(:tem_ins)
    @umd_ins = fetch_and_process_data(:umd_ins)
    @rad_glo = fetch_and_process_data(:rad_glo)
    @chuva   = fetch_and_process_data(:chuva)
    @pre_ins = fetch_and_process_data(:pre_ins)
    @ven_vel = fetch_and_process_data(:ven_vel)
    @time    = @inmet_weather_data.collect { |t| t.hr_medicao.to_time_br }
  end

  def data_range
    @inmet_weather_data = fetch_inmet_weather_data_range

    @tem_ins_range = fetch_and_process_data(:avg_tem_ins)
    @umd_ins_range = fetch_and_process_data(:avg_umd_ins)
    @rad_glo_range = fetch_and_process_data(:avg_rad_glo)
    @chuva_range   = fetch_and_process_data(:avg_chuva)
    @pre_ins_range = fetch_and_process_data(:avg_pre_ins)
    @ven_vel_range = fetch_and_process_data(:avg_ven_vel)

    @time_range    = @inmet_weather_data.collect { |t| t.hr_medicao.to_date_br }
  end

  private

  def fetch_and_process_data(attribute)
    @inmet_weather_data.collect { |t| t.public_send(attribute).to_f.round(2) }.compact
  end

  def fetch_inmet_weather_data
    Time.use_zone("America/Sao_Paulo") do
      @start_time = Time.zone.parse(params[:data_fim].to_s).beginning_of_day
      @end_time = Time.zone.parse(params[:data_fim].to_s).end_of_day
    end

    InmetWeatherDatum.filter(by_cdg_station: @cdg_station)
                     .where(hr_medicao: @start_time..@end_time)
                     .order(:inmet_weather_station_id, :dta_medicao, :hr_medicao)
  end


  def fetch_inmet_weather_data_range
    Time.use_zone("America/Sao_Paulo") do
      @start_time = Time.zone.parse(params[:data_inicio].to_s).beginning_of_day
      @end_time = Time.zone.parse(params[:data_fim].to_s).end_of_day
    end

    InmetWeatherDatum
      .filter(by_cdg_station:  @cdg_station)
      .where(hr_medicao: @start_time..@end_time)
      .group("DATE(hr_medicao AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo')")
      .select(*selection_attributes)
      .order("hr_medicao")
  end

  def selection_attributes
    [
      "DATE(hr_medicao AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo') as hr_medicao",
      "AVG(pre_ins) AS avg_pre_ins",
      "AVG(tem_sem) AS avg_tem_sem",
      "AVG(pre_max) AS avg_pre_max",
      "AVG(rad_glo) AS avg_rad_glo",
      "AVG(pto_ins) AS avg_pto_ins",
      "AVG(tem_min) AS avg_tem_min",
      "AVG(umd_min) AS avg_umd_min",
      "AVG(pto_max) AS avg_pto_max",
      "AVG(ven_dir) AS avg_ven_dir",
      "AVG(chuva) AS avg_chuva",
      "AVG(pre_min) AS avg_pre_min",
      "AVG(umd_max) AS avg_umd_max",
      "AVG(ven_vel) AS avg_ven_vel",
      "AVG(pto_min) AS avg_pto_min",
      "AVG(tem_max) AS avg_tem_max",
      "AVG(ven_raj) AS avg_ven_raj",
      "AVG(tem_ins) AS avg_tem_ins",
      "AVG(umd_ins) AS avg_umd_ins"
    ]
  end

  def default_date
    params[:data_fim] = params[:data_fim] || Time.current.to_brz.to_date
    params[:data_inicio] = params[:data_inicio] || (Time.current.to_brz.to_date-30.day)
  end

  def default_filter
    @cidade = InmetWeatherStation.all.collect{ |t| t.cidade }.uniq
    @type_data = !(params[:type_data] == 'false')
    @cdg_station = params[:cdg_station] ||= 'A002'
  end

end
