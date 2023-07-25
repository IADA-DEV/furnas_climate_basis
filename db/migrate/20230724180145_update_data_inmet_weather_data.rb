class UpdateDataInmetWeatherData < ActiveRecord::Migration[7.0]
  def change
    change_column :data_import_inmets, :inmet_weather_station_id, :string
  end
end
