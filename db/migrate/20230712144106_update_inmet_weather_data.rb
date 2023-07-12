class UpdateInmetWeatherData < ActiveRecord::Migration[7.0]
  def change
    change_column :inmet_weather_data, :inmet_weather_station_id, :string
  end
end
