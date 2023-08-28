class PopulationDateTimeBrzToInmetData < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      UPDATE
        inmet_weather_data
      SET
        data_time_brz = hr_medicao AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo'
      WHERE
        data_time_brz is null
    SQL
  end

  def down
    execute <<-SQL
      UPDATE
        inmet_weather_data
      SET
        data_time_brz = null
      WHERE
        data_time_brz is not null
    SQL
  end
end
