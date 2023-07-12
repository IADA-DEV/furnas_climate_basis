json.extract! inmet_weather_datum, :id, :created_at, :updated_at
json.url inmet_weather_datum_url(inmet_weather_datum, format: :json)
