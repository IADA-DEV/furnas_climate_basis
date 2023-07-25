class DataImportInmetWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'low'

  def perform(dta_inicio, dta_fim, id_station, id_import)
    results = Inmet::InmetWeatherService.data(dta_inicio, dta_fim, id_station)

    results.each do |attr|
      InmetWeatherDatum.inport_create(attr)
    end

    DataImportInmet.find(id_import).update(status: true)

  end

end