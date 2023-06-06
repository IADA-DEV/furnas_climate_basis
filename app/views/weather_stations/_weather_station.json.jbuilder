json.extract! weather_station, :id, :cidade, :sg_estado, :situacao, :vl_latitude, :vl_longitude, :vl_altitude, :dta_inicio_operacao, :cdg_estacao, :created_at, :updated_at
json.url weather_station_url(weather_station, format: :json)
