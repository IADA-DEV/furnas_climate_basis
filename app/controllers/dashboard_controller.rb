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
        format.html { render partial: params[:partial]}
      else
        format.html
      end
    end

  end

  def grafico
  end

  def filter_station
    config = current_user.config_system

    if config.update_attribute(:cdg_station, params[:cdg_station])
      redirect_to dashboard_index_path
    end
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

    @tem_ins_stats = [ calculate_statistics(@tem_ins, params[:data_fim].to_date.to_date_b) ]
    @umd_ins_stats = [ calculate_statistics(@umd_ins, params[:data_fim].to_date.to_date_b) ]
    @rad_glo_stats = [ calculate_statistics(@rad_glo, params[:data_fim].to_date.to_date_b) ]
    @chuva_stats   = [ calculate_statistics(@chuva, params[:data_fim].to_date.to_date_b  ) ]
    @pre_ins_stats = [ calculate_statistics(@pre_ins, params[:data_fim].to_date.to_date_b) ]
    @ven_vel_stats = [ calculate_statistics(@ven_vel, params[:data_fim].to_date.to_date_b) ]

    @time    = @inmet_weather_data.collect { |t| t.hr_medicao.to_brz.to_time_b }
  end

  def data_range
    @inmet_weather_data = fetch_inmet_weather_data_range

    @tem_ins_range = fetch_and_process_data(:avg_tem_ins)
    @umd_ins_range = fetch_and_process_data(:avg_umd_ins)
    @rad_glo_range = fetch_and_process_data(:avg_rad_glo)
    @chuva_range   = fetch_and_process_data(:avg_chuva)
    @pre_ins_range = fetch_and_process_data(:avg_pre_ins)
    @ven_vel_range = fetch_and_process_data(:avg_ven_vel)

    @time_range    = @inmet_weather_data.collect { |t| t.hr_medicao.to_date_b }

    @tem_ins_stats_range = []
    @umd_ins_stats_range = []
    @rad_glo_stats_range = []
    @chuva_stats_range   = []
    @pre_ins_stats_range = []
    @ven_vel_stats_range = []

    fetch_inmet_weather_data_range_status.group_by { |item| item.hr_medicao }.each do |obj|
      @tem_ins_stats_range << calculate_statistics(obj[1].collect { |t| t.public_send(:tem_ins).to_f.round(2) }.compact, obj[0].to_date_b)
      @umd_ins_stats_range << calculate_statistics(obj[1].collect { |t| t.public_send(:umd_ins).to_f.round(2) }.compact, obj[0].to_date_b)
      @rad_glo_stats_range << calculate_statistics(obj[1].collect { |t| t.public_send(:rad_glo).to_f.round(2) }.compact, obj[0].to_date_b)
      @chuva_stats_range << calculate_statistics(obj[1].collect { |t| t.public_send(:chuva).to_f.round(2) }.compact, obj[0].to_date_b)
      @pre_ins_stats_range << calculate_statistics(obj[1].collect { |t| t.public_send(:pre_ins).to_f.round(2) }.compact, obj[0].to_date_b)
      @ven_vel_stats_range << calculate_statistics(obj[1].collect { |t| t.public_send(:ven_vel).to_f.round(2) }.compact, obj[0].to_date_b)
    end

  end

  def calculate_statistics(data, date)
    return nil if data.nil? || data.empty?

    data.compact!
    data.sort!

    n = data.length
    l = (n * 0.25).to_i
    u = (n * 0.75).to_i

    q1 = data[l]
    median = (data[(n - 1) / 2] + data[n / 2]) / 2.0
    q3 = data[u]

    min = data.first
    max = data.last

    { date: date, data: [min, q1, median, q3, max]}
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
      .select(*selection_attributes_avg)
      .order("hr_medicao")
  end

  def fetch_inmet_weather_data_range_status
    Time.use_zone("America/Sao_Paulo") do
      @start_time = Time.zone.parse(params[:data_inicio].to_s).beginning_of_day
      @end_time = Time.zone.parse(params[:data_fim].to_s).end_of_day
    end

    InmetWeatherDatum
      .filter(by_cdg_station:  @cdg_station)
      .where(hr_medicao: @start_time..@end_time)
      .select(*selection_attributes)
  end

  def selection_attributes_avg
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

  def selection_attributes
    [
      "DATE(hr_medicao AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo') as hr_medicao",
      "pre_ins",
      "tem_sem",
      "pre_max",
      "rad_glo",
      "pto_ins",
      "tem_min",
      "umd_min",
      "pto_max",
      "ven_dir",
      "chuva",
      "pre_min",
      "umd_max",
      "ven_vel",
      "pto_min",
      "tem_max",
      "ven_raj",
      "tem_ins",
      "umd_ins"
    ]
  end

  def default_date
    params[:data_fim] = params[:data_fim] || Time.current.to_brz.to_date
    params[:data_inicio] = params[:data_inicio] || (Time.current.to_brz.to_date-30.day)
  end

  def default_filter
    @cidade = InmetWeatherStation.all.collect{ |t| [t.cidade, t.cdg_estacao] }.uniq
    @type_data = !(params[:type_data] == 'false')
    @cdg_station = params[:cdg_station] ||= current_user.cdg_station
  end

end
