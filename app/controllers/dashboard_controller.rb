class DashboardController < ApplicationController
  before_action :default_filter, only: [:index]
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


  def default_filter
    @cidade = InmetWeatherStation.all.collect{ |t| t.cidade }.uniq
    @type_data = !(params[:type_data] == "false")
    @cdg_station = params[:cdg_station] ||= 'A002'

    params[:range_data_fim] = Date.current.to_s if !params[:range_data_fim]
    params[:range_data_inicio] = (params[:range_data_fim].to_date - 30.day).to_s if !params[:range_data_inicio]
  end

  def daily_today
    @inmet_weather_data = InmetWeatherDatum
                            .filter(by_cdg_station: @cdg_station,
                                    by_dta_medicao: params[:data_inicio] || Date.current.to_s)
                            .order(:inmet_weather_station_id, :dta_medicao, :hr_medicao)

    @tem_ins = @inmet_weather_data.collect { |t| t.tem_ins.to_f.round(2) }.compact
    @umd_ins = @inmet_weather_data.collect { |t| t.umd_ins.to_f.round(2) }.compact
    @rad_glo = @inmet_weather_data.collect { |t| t.rad_glo.to_f.round(2) }.compact
    @chuva = @inmet_weather_data.collect { |t| t.chuva.to_f.round(2) }.compact
    @pre_ins = @inmet_weather_data.collect { |t| t.pre_ins.to_f.round(2) }.compact
    @ven_vel = @inmet_weather_data.collect { |t| t.ven_vel.to_f.round(2) }.compact
    @time = @inmet_weather_data.collect { |t| t.hr_medicao.to_time_br }
  end

  def data_range
    @inmet_weather_data_range = InmetWeatherDatum
                            .filter(by_cdg_station: 'A002')
                            .where(dta_medicao: params[:range_data_inicio]..params[:range_data_fim])
                            .group(:dta_medicao)
                            .select(
                              :dta_medicao,
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
                            )
                            .order(:dta_medicao)

    @tem_ins_range = @inmet_weather_data_range.collect { |t| t.avg_tem_ins.to_f.round(2) }.compact
    @umd_ins_range = @inmet_weather_data_range.collect { |t| t.avg_umd_ins.to_f.round(2) }.compact
    @rad_glo_range = @inmet_weather_data_range.collect { |t| t.avg_rad_glo.to_f.round(2) }.compact
    @chuva_range = @inmet_weather_data_range.collect { |t| t.avg_chuva.to_f.round(2) }.compact
    @pre_ins_range = @inmet_weather_data_range.collect { |t| t.avg_pre_ins.to_f.round(2) }.compact
    @ven_vel_range = @inmet_weather_data_range.collect { |t| t.avg_ven_vel.to_f.round(2) }.compact
    @time_range = @inmet_weather_data_range.collect { |t| t.dta_medicao.to_date_b }
  end

end
