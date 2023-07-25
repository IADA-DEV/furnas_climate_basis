class DataImportInmet < ApplicationRecord
  
  belongs_to :inmet_weather_station, foreign_key: 'inmet_weather_station_id'

  after_commit :update_status


  private

  def update_status
    if DataImportInmet.where(inmet_weather_station_id: self.inmet_weather_station_id, status: false).present? 
      self.inmet_weather_station.update(status: 2)
    else
      self.inmet_weather_station.update(status: 3)
    end
  end

end
