class DashboardController < ApplicationController

  def index
    @station = InmetWeatherStation.all
    # @size_station = @station.count
    # @operante = @station.where(situacao: "Operante").size
    # @pane = @station.where(situacao: "Pane").size
    @cidade = @station.collect{ |t| t.cidade }.uniq

    # @data = InmetWeatherDatum.all.size

    @inmet_weather_data = InmetWeatherDatum
                            .filter(by_cdg_station: 'A002',
                                    by_dta_medicao: Date.current.to_s)
                            .order(:inmet_weather_station_id, :dta_medicao, :hr_medicao)

    @tem_ins = @inmet_weather_data.collect { |t| t.tem_ins.to_i }.compact
    @umd_ins = @inmet_weather_data.collect { |t| t.umd_ins.to_i }.compact
    @rad_glo = @inmet_weather_data.collect { |t| t.rad_glo }.compact
    @chuva = @inmet_weather_data.collect { |t| t.chuva }.compact
    @pre_ins = @inmet_weather_data.collect { |t| t.pre_ins }.compact
    @ven_vel = @inmet_weather_data.collect { |t| t.ven_vel }.compact


    @time = @inmet_weather_data.collect { |t| t.hr_medicao.to_time_br }


    # @tem_ins_normalized = min_max_scale(@tem_ins)
    # @umd_ins_normalized = min_max_scale(@umd_ins)
    @rad_glo_normalized = min_max_scale(@rad_glo)
    # @chuva_normalized = min_max_scale(@chuva)
    @pre_ins_normalized = min_max_scale(@pre_ins)
    # @ven_vel_normalized = min_max_scale(@ven_vel)
  end

  def grafico
  end

  # Min-max scaling function
  def min_max_scale(arr)
    min_val = arr.min
    max_val = arr.max
    scaled_arr = arr.map { |val| (((val - min_val) / (max_val - min_val)) * 100).round(2) }
    return scaled_arr
  end


end
