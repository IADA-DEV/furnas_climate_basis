class ImportStationNoaWorker
  include Sidekiq::Worker


  def perform(page)
    if page.present?
      if Noa::NoaWeatherService.noa_daily_request_limit_reached?
        if Noa::NoaWeatherService.noa_request_limit_reached?
          import_data_station(page)
        else
          ImportStationNoaWorker.perform_in(1.minute, page)
        end
      else
        ImportStationNoaWorker.perform_at(Time.current.tomorrow.beginning_of_day, page)
      end
    end
  end

  def import_data_station(page)
    results = Noa::NoaWeatherService.stations(page)

    results.each do |data|
      NoaWeatherStation.find_create_or_update(data)
    end
  end

end