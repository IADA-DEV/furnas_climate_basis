class ImportStationNoaJob < ApplicationJob
  queue_as :default


  def perform(*args)
    page = args.first
    if page.presente
      NoaWeatherStation.consumo_weather_data(page)
    end
  end
end
