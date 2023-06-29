class CreateNoaWeatherStations < ActiveRecord::Migration[7.0]
  def change
    create_table :noa_weather_stations do |t|
      t.decimal :vl_latitude      , comment: 'VALOR DA LATITUDE'            , precision: 65, scale: 30   # "latitude": -0.73,
      t.decimal :vl_longitude     , comment: 'VALOR DA LONGITUDE'           , precision: 65, scale: 30   # "longitude": -47.85
      t.decimal :vl_altitude      , comment: 'VALOR DA ALTITUDE'            , precision: 65, scale: 30   # "elevation": 0,

      t.string :cdg_estacao       , comment: 'CODIGO DA ESTACAO - UNICO'   # "id": "GHCND:BR000047003",
      t.string :name            , comment: 'Nome da Cidade'                # "name": "CURUCA, BR",
      t.date :dta_inicio_operacao , comment: 'DATA DE INICIO DE REGISTROS' # "mindate": "1981-07-01",
      t.date :dta_fim_operacao , comment: 'DATA DE Fim DE REGISTROS'       # "maxdate": "1999-12-31",
      t.float :datacoverage, commet: '?'                                   # "datacoverage": 0.7612,
      t.float :elevationUnit, commet: '?'                                  # "elevationUnit": "METERS",

      t.timestamps
    end

    add_index :noa_weather_stations, :cdg_estacao
    add_index :V, :name
  end
end
