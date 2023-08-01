class CreateInmetWeatherData < ActiveRecord::Migration[7.0]
  def change
    create_table :inmet_weather_data do |t|
      t.float :pre_ins                       , comment: 'Pressao Ins. (hPa)'
      t.float :tem_sem                       , comment: '???????????'
      t.float :pre_max                       , comment: 'Pressao Max. (hPa)'
      t.float :rad_glo                       , comment: 'Radiacao (KJ/m¬≤)'
      t.float :pto_ins                       , comment: 'Pto Orvalho Ins. (C)'
      t.float :tem_min                       , comment: 'Temp. Min. (C)'
      t.float :umd_min                       , comment: 'Umi. Min. (%)'
      t.float :pto_max                       , comment: 'Pto Orvalho Max. (C)'
      t.float :ven_dir                       , comment: 'Dir. Vento (m/s)'
      t.date :dta_medicao                    , comment: 'Data da Medição'
      t.float :chuva                         , comment: 'Chuva (mm)'
      t.float :pre_min                       , comment: 'Pressao Min. (hPa)'
      t.float :umd_max                       , comment: 'Umi. Max. (%)'
      t.float :ven_vel                       , comment: 'Vel. Vento (m/s)'
      t.float :pto_min                       , comment: 'Pto Orvalho Min. (C)'
      t.float :tem_max                       , comment: 'Temp. Max. (C)'
      t.float :ven_raj                       , comment: 'Raj. Vento (m/s)'
      t.float :tem_ins                       , comment: 'Temp. Ins. (C)'
      t.float :umd_ins                       , comment: 'Umi. Ins. (%)'
      t.belongs_to :inmet_weather_station    , comment: 'ID da Estação', null: false
      t.datetime :hr_medicao                 , comment: 'Hora (UTC)'
      # t.string :ano                          , comment: 'Ano'
      # t.string :mes                          , comment: 'Mes'
      # t.string :dia                          , comment: 'Dia'

      t.timestamps
    end

    add_index :inmet_weather_data, :dta_medicao
    add_index :inmet_weather_data, :hr_medicao
    
  end
end
