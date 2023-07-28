class DataImportTodayInmetWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'high'

  def perform(time)
    results = Inmet::InmetWeatherService.data_time_today(time)

    results.each do |attr|
      InmetWeatherDatum.inport_find_or_create(attr) if InmetWeatherStation.find_by(cdg_estacao: attr['CD_ESTACAO'])
    end

  end

end