class ImportStationNoaWorker
  include Sidekiq::Worker


  def perform(page)
    if page.present?
      NoaWeatherStation.consumo_weather_data(page)
    end
  end
end