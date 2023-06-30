class ImportStationNoaWorker
  include Sidekiq::Worker


  def perform(page)
    if page.present?
      results = Noa::NoaWeatherService.stations(page)

      results.each do |data|
        NoaWeatherStation.find_create_or_update(data)
      end

    end
  end
end