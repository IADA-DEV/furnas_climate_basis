class DashboardController < ApplicationController
  before_action :default_filter, only: [:index]
  before_action :default_date
  before_action :data_range, only: [:index]

  def index
    respond_to do |format|
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

  def data_range
    @data = fetch_inmet_weather_data

    if  params[:amostragem] == 'Hora a Hora'
      time_to_time
    else
      diario
    end

  end

  def diario
    @temperatura, @time = @data.fetch_and_process_data_m(:tem_ins).transpose
    @humidade, @time    = @data.fetch_and_process_data_m(:umd_ins).transpose
    @radiacao, @time    = @data.fetch_and_process_data_m(:rad_glo).transpose
    @chuva, @time       = @data.fetch_and_process_data_m(:chuva).transpose
    @presao, @time      = @data.fetch_and_process_data_m(:pre_ins).transpose
    @vento, @time       = @data.fetch_and_process_data_m(:ven_vel).transpose
  end

  def time_to_time
    @temperatura, @time = @data.fetch_and_process_data(:tem_ins).transpose
    @humidade, @time    = @data.fetch_and_process_data(:umd_ins).transpose
    @radiacao, @time    = @data.fetch_and_process_data(:rad_glo).transpose
    @chuva, @time       = @data.fetch_and_process_data(:chuva).transpose
    @presao, @time      = @data.fetch_and_process_data(:pre_ins).transpose
    @vento, @time       = @data.fetch_and_process_data(:ven_vel).transpose
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

  def fetch_inmet_weather_data
    Time.use_zone("America/Sao_Paulo") do
      @start_time = Time.zone.parse(params[:data_inicio].to_s).beginning_of_day
      @end_time = Time.zone.parse(params[:data_fim].to_s).end_of_day
    end

    InmetWeatherDatum.filter(by_cdg_station: @cdg_station)
                     .where(hr_medicao: @start_time..@end_time)
                     .order(:hr_medicao)
  end

  def default_date
    params[:data_fim] = params[:data_fim] || Time.current.to_brz.to_date
    params[:data_inicio] = params[:data_inicio] || Time.current.to_brz.to_date
    params[:amostragem] = params[:amostragem] || 'Hora a Hora'
  end

  def default_filter
    current_user.config_system.update_attribute(:cdg_station, params[:cdg_station]) if  params[:cdg_station] && current_user.cdg_station != params[:cdg_station]

    @cidade = InmetWeatherStation.all.collect{ |t| [t.cidade, t.cdg_estacao] }.uniq
    @type_data = !(params[:type_data] == 'false')
    @cdg_station = params[:cdg_station] ||= current_user.cdg_station
  end

end
