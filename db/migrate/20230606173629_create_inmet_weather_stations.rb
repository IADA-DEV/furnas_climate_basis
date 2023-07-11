class CreateInmetWeatherStations < ActiveRecord::Migration[7.0]
  def change
    create_table :inmet_weather_stations do |t|
      t.string :cidade            , comment: 'Nome da Cidade'
      t.string :sg_estado         , comment: 'Simbulo cidade'
      t.string :situacao          , comment: 'CONDICAO - SE ESTA EM OPERACAO'
      t.decimal :vl_latitude      , comment: 'VALOR DA LATITUDE'            , precision: 65, scale: 30
      t.decimal :vl_longitude     , comment: 'VALOR DA LONGITUDE'           , precision: 65, scale: 30
      t.decimal :vl_altitude      , comment: 'VALOR DA ALTITUDE'            , precision: 65, scale: 30
      t.date :dta_inicio_operacao , comment: 'DATA DE INICIO DE REGISTROS'
      t.string :cdg_estacao       , comment: 'CODIGO DA ESTACAO - UNICO'
      t.string :nme_estado        , comment: 'NOME DO ESTADO'
      t.string :cdg_regiao        , comment: 'REGIÃO DO ESTADO'

      t.timestamps
    end

    add_index :inmet_weather_stations, :sg_estado
    add_index :inmet_weather_stations, :cdg_regiao
    add_index :inmet_weather_stations, :nme_estado
    add_index :inmet_weather_stations, :situacao
  end
end
