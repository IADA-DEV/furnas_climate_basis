class NoaWeatherStation < ApplicationRecord
  include Filterable






  def self.consumo_weather_data
      has_dados  = []

      url = 'https://www.ncdc.noaa.gov/cdo-web/api/v2/stations?locationid=FIPS%3ABR&limit=50'
      headers = { 'token' => 'HlENBnpTzcwcPwTAwPAfvNYzZGgnfOQL' }


      response = RestClient.get(url, headers)



      resp_json = JSON.parse(response.body)

      # resp_json['metadata']
      resp_json['results'].each do |data|
        NoaWeatherStation.create(
          "vl_altitude":         data['elevation'],
          "dta_inicio_operacao": data['mindate'],
          "dta_fim_operacao":    data['maxdate'],
          "vl_latitude":         data['latitude'],
          "name":                data['name'],
          "datacoverage":        data['datacoverage'],
          "cdg_estacao":         data['id'],
          "elevationUnit":       data['elevationUnit'],
          "vl_longitude":        data['longitude']
        )
      end
    end

end
