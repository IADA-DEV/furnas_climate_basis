class InmetWeatherStation < ApplicationRecord
  include Filterable
  include EstadoHelper

  self.primary_key = 'cdg_estacao'

  # scopes
  scope :by_cidade, ->(params) { where(cidade: params) }
  scope :by_cdg_estacao, ->(params) { where(cdg_estacao: params) }
  scope :by_nme_estado, ->(params) { where(nme_estado: params) }
  scope :by_situacao, ->(params) { where(situacao: params) }

  #actions
  before_create :type_regiao

  # methods class
  def self.inport_create(data)
    InmetWeatherStation.create(
      cidade: data['DC_NOME'],
      situacao: data['CD_SITUACAO'],
      sg_estado: data['SG_ESTADO'],
      vl_latitude: data['VL_LATITUDE'],
      vl_altitude: data['VL_ALTITUDE'],
      cdg_estacao: data['CD_ESTACAO'],
      vl_longitude: data['VL_LONGITUDE'],
      dta_inicio_operacao: data['DT_INICIO_OPERACAO']
    )
  end

  def self.inport_update(obj, data)
    obj.update(
      cidade: data['DC_NOME'],
      situacao: data['CD_SITUACAO'],
      sg_estado: data['SG_ESTADO'],
      vl_latitude: data['VL_LATITUDE'],
      vl_altitude: data['VL_ALTITUDE'],
      cdg_estacao: data['CD_ESTACAO'],
      vl_longitude: data['VL_LONGITUDE'],
      dta_inicio_operacao: data['DT_INICIO_OPERACAO']
    )
  end

  def self.find_create_or_update(data)
    obj = InmetWeatherStation.find_by(cdg_estacao: data['CD_ESTACAO'])
    
    if obj.present?
      inport_update(obj, data)
    else
      inport_create(data)
    end
  end

end
