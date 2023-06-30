class NoaWeatherStation < ApplicationRecord
  # includes 
  include Filterable


  # scopes 
  scope :by_cdg_estacao, ->(params) { where(cdg_estacao: params) }

  
  # methods class
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
