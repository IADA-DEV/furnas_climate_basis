class ImportStationInmetWorker
  include Sidekiq::Worker


  def perform()
    results = Inmet::InmetWeatherService.stations()

    results.each do |obj|
      InmetWeatherStation.find_create_or_update(obj)
    end

  end
end