class DataImportInmetWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'low'

  def perform(dta_inicio, dta_fim, id_station, id_import)
    results = Inmet::InmetWeatherService.data(dta_inicio, dta_fim, id_station)

    results.each do |attr|
      obj = InmetWeatherDatum.inport_create(attr)
      unless obj.persisted?
            LogErro.create(
                model: 'DataImportInmetWorker',
                description: attr.to_json,
                erro: obj.errors.full_messages.join(', ')
            )
      end
    end

    DataImportInmet.find_by(id: id_import).update(status: true)

  end

end