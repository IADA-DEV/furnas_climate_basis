class NoaWeatherStation < ApplicationRecord
  include Filterable

  scope :by_cdg_estacao, ->(params) { where(cdg_estacao: params) }

  def self.all_import_page
    url = URL_NOA + 'locationid=FIPS%3ABR&limit=1'
    headers = { 'token' => TOKEN_NOA }

    response = RestClient.get(url, headers)

    resp_json = JSON.parse(response.body)['metadata']['resultset']['count']

    return (resp_json/1000.0).ceil
  end

  def self.consumo_weather_data(page) 
      url = URL_NOA +  "locationid=FIPS%3ABR&limit=1000&offset=#{page}"
      headers = { 'token' => TOKEN_NOA }

      response = RestClient.get(url, headers)
  
      resp_json = JSON.parse(response.body)

      resp_json['results'].each do |data|
        find_create_or_update(data)
      end
  end

  def self.inport_create(data)
    NoaWeatherStation.create(
      name:                data['name'],
      cdg_estacao:         data['id'],
      vl_altitude:         data['elevation'],
      vl_latitude:         data['latitude'],
      vl_longitude:        data['longitude'],
      datacoverage:        data['datacoverage'],
      elevationUnit:       data['elevationUnit'],
      dta_fim_operacao:    data['maxdate'],
      dta_inicio_operacao: data['mindate']
    )
  end

  def self.inport_update(obj, data)
    obj.update(
      name:                data['name'],
      cdg_estacao:         data['id'],
      vl_altitude:         data['elevation'],
      vl_latitude:         data['latitude'],
      vl_longitude:        data['longitude'],
      datacoverage:        data['datacoverage'],
      elevationUnit:       data['elevationUnit'],
      dta_fim_operacao:    data['maxdate'],
      dta_inicio_operacao: data['mindate']
    )
  end

  def self.find_create_or_update(data)
    obj = NoaWeatherStation.find_by(cdg_estacao: data['id'])
    if obj.present?
      inport_update(obj, data)
    else
      inport_create(data)
    end
  end

end
