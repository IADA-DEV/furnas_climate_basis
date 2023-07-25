class DataImportScheduleInmetWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'default'

  def perform(id_station)
    station = InmetWeatherStation.find(id_station)
    date = station.dta_inicio_operacao
    current_date = Date.current - 1.day

    while date < current_date
      next_date = calcular_proxima_data(date)

      import = DataImportInmet.create(dta_inicio: date, dta_fim: next_date, inmet_weather_station_id: id_station)

      DataImportInmetWorker.perform_async(date.to_s, next_date.to_s, id_station, import.id)
      date = next_date + 1.day
    end
  end

  private

  def calcular_proxima_data(date)
    proxima_data = date + 1.month
    proxima_data = Date.current - 1.day if proxima_data > (Date.current - 1.day)
    proxima_data
  end
end
