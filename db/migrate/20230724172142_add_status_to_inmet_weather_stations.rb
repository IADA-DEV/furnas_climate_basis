class AddStatusToInmetWeatherStations < ActiveRecord::Migration[7.0]
  def change
    add_column :inmet_weather_stations, :status, :integer, default: 0
  end
end
