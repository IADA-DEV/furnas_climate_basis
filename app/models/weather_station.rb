class WeatherStation < ApplicationRecord
  include Filterable

  scope :by_cidade, ->(params) { where(cidade: params) }
  scope :by_cdg_estacao, ->(params) { where(cdg_estacao: params) }
  scope :by_nme_estado, ->(params) { where(nme_estado: params) }
  scope :by_situacao, ->(params) { where(situacao: params) }
end
