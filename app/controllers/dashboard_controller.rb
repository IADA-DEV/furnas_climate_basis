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

    if params[:amostragem] == 'Hora a Hora'
      time_to_time
    else
      diario
    end

    data_histograma
  end

  def data_histograma
    @temperatura_histograma = calcular_histograma(@temperatura, ' ºC')
    @humidade_histograma = calcular_histograma(@humidade, ' %')
    @chuva_histograma = calcular_histograma(@chuva, ' mm')
    @radiacao_histograma = calcular_histograma(@radiacao, ' (KJ/m¬≤)')
    @vento_histograma = calcular_histograma(@vento, ' m/s')
    @presao_histograma = calcular_histograma(@presao, ' hPa')
  end

  def diario
    @grouped_data = @data.group_by { |t| t.hr_medicao.to_date }

    @temperatura, @time = @data.fetch_and_process_data_m(:tem_ins, @grouped_data).transpose
    @humidade, @time    = @data.fetch_and_process_data_m(:umd_ins, @grouped_data).transpose
    @radiacao, @time    = @data.fetch_and_process_data_m(:rad_glo, @grouped_data).transpose
    @chuva, @time       = @data.fetch_and_process_data_m(:chuva,   @grouped_data).transpose
    @presao, @time      = @data.fetch_and_process_data_m(:pre_ins, @grouped_data).transpose
    @vento, @time       = @data.fetch_and_process_data_m(:ven_vel, @grouped_data).transpose
  end

  def time_to_time
    @temperatura, @time = @data.fetch_and_process_data(:tem_ins).transpose
    @humidade, @time    = @data.fetch_and_process_data(:umd_ins).transpose
    @radiacao, @time    = @data.fetch_and_process_data(:rad_glo).transpose
    @chuva, @time       = @data.fetch_and_process_data(:chuva).transpose
    @presao, @time      = @data.fetch_and_process_data(:pre_ins).transpose
    @vento, @time       = @data.fetch_and_process_data(:ven_vel).transpose
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

  def calcular_histograma(data, u_m)
    # Remova os valores zero do array
    data = data.reject { |value| value.zero? }

    # Verifique se ainda há dados restantes após a remoção dos zeros
    if data.empty?
      puts "Não há dados para calcular o histograma, pois todos os valores são zero."
      return []
    end

    # Calcular o número de intervalos usando a regra de Sturges
    n = data.length
    k = (1 + 3.322 * Math.log10(n)).ceil

    # Calcular a largura de cada intervalo
    data_min = data.min
    data_max = data.max
    interval_width = (data_max - data_min) / k

    # Inicializar um hash para armazenar as frequências
    histogram = Hash.new(0)

    # Criar os intervalos e contar a frequência de dados dentro de cada intervalo
    data.each do |value|
      interval_start = (value / interval_width).floor * interval_width
      interval_end = interval_start + interval_width
      interval_str = "#{interval_start.round(1)} #{u_m} - #{interval_end.round(1)} #{u_m}"

      histogram[interval_str] += 1
    end

    # Formatar os resultados como um array de hashes
    result = histogram.map { |interval, frequency| { x: interval, y: frequency } }

    # Ordenar os intervalos em ordem crescente
    result.sort_by! { |hash| hash[:x] }

    return result
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

end
