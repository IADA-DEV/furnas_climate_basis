class DataImportInmet < ApplicationRecord
  
  belongs_to :inmet_weather_station, foreign_key: 'inmet_weather_station_id'

  after_update :update_status


  private

  def update_status
    unless DataImportInmet.where(inmet_weather_station_id: self.inmet_weather_station_id, status: false).present? 
      self.inmet_weather_station.update(status: 3)
    end
  end

end
