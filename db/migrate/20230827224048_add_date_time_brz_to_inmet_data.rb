class AddDateTimeBrzToInmetData < ActiveRecord::Migration[7.0]
  def change
    add_column :inmet_weather_data, :data_time_brz, :datetime

    add_index :inmet_weather_data, :data_time_brz
  end
end
