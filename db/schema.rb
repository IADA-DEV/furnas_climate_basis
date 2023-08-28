# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_01_131009) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_import_inmets", force: :cascade do |t|
    t.date "dta_inicio"
    t.date "dta_fim"
    t.boolean "status"
    t.string "inmet_weather_station_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inmet_weather_station_id"], name: "index_data_import_inmets_on_inmet_weather_station_id"
    t.index ["status"], name: "index_data_import_inmets_on_status"
  end

  create_table "inmet_weather_data", force: :cascade do |t|
    t.float "pre_ins", comment: "Pressao Ins. (hPa)"
    t.float "tem_sem", comment: "???????????"
    t.float "pre_max", comment: "Pressao Max. (hPa)"
    t.float "rad_glo", comment: "Radiacao (KJ/m¬≤)"
    t.float "pto_ins", comment: "Pto Orvalho Ins. (C)"
    t.float "tem_min", comment: "Temp. Min. (C)"
    t.float "umd_min", comment: "Umi. Min. (%)"
    t.float "pto_max", comment: "Pto Orvalho Max. (C)"
    t.float "ven_dir", comment: "Dir. Vento (m/s)"
    t.date "dta_medicao", comment: "Data da Medição"
    t.float "chuva", comment: "Chuva (mm)"
    t.float "pre_min", comment: "Pressao Min. (hPa)"
    t.float "umd_max", comment: "Umi. Max. (%)"
    t.float "ven_vel", comment: "Vel. Vento (m/s)"
    t.float "pto_min", comment: "Pto Orvalho Min. (C)"
    t.float "tem_max", comment: "Temp. Max. (C)"
    t.float "ven_raj", comment: "Raj. Vento (m/s)"
    t.float "tem_ins", comment: "Temp. Ins. (C)"
    t.float "umd_ins", comment: "Umi. Ins. (%)"
    t.string "inmet_weather_station_id", null: false, comment: "ID da Estação"
    t.datetime "hr_medicao", comment: "Hora (UTC)"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dta_medicao"], name: "index_inmet_weather_data_on_dta_medicao"
    t.index ["hr_medicao"], name: "index_inmet_weather_data_on_hr_medicao"
    t.index ["inmet_weather_station_id"], name: "index_inmet_weather_data_on_inmet_weather_station_id"
  end

  create_table "inmet_weather_stations", force: :cascade do |t|
    t.string "cidade", comment: "Nome da Cidade"
    t.string "sg_estado", comment: "Simbulo cidade"
    t.string "situacao", comment: "CONDICAO - SE ESTA EM OPERACAO"
    t.decimal "vl_latitude", precision: 65, scale: 30, comment: "VALOR DA LATITUDE"
    t.decimal "vl_longitude", precision: 65, scale: 30, comment: "VALOR DA LONGITUDE"
    t.decimal "vl_altitude", precision: 65, scale: 30, comment: "VALOR DA ALTITUDE"
    t.date "dta_inicio_operacao", comment: "DATA DE INICIO DE REGISTROS"
    t.string "cdg_estacao", comment: "CODIGO DA ESTACAO - UNICO"
    t.string "nme_estado", comment: "NOME DO ESTADO"
    t.string "cdg_regiao", comment: "REGIÃO DO ESTADO"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["cdg_regiao"], name: "index_inmet_weather_stations_on_cdg_regiao"
    t.index ["nme_estado"], name: "index_inmet_weather_stations_on_nme_estado"
    t.index ["sg_estado"], name: "index_inmet_weather_stations_on_sg_estado"
    t.index ["situacao"], name: "index_inmet_weather_stations_on_situacao"
  end

  create_table "log_erros", force: :cascade do |t|
    t.string "model"
    t.text "description"
    t.text "erro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "noa_weather_stations", force: :cascade do |t|
    t.decimal "vl_latitude", precision: 65, scale: 30, comment: "VALOR DA LATITUDE"
    t.decimal "vl_longitude", precision: 65, scale: 30, comment: "VALOR DA LONGITUDE"
    t.decimal "vl_altitude", precision: 65, scale: 30, comment: "VALOR DA ALTITUDE"
    t.string "cdg_estacao", comment: "CODIGO DA ESTACAO - UNICO"
    t.string "name", comment: "Nome da Cidade"
    t.date "dta_inicio_operacao", comment: "DATA DE INICIO DE REGISTROS"
    t.date "dta_fim_operacao", comment: "DATA DE Fim DE REGISTROS"
    t.float "datacoverage"
    t.float "elevationUnit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cdg_estacao"], name: "index_noa_weather_stations_on_cdg_estacao"
    t.index ["name"], name: "index_noa_weather_stations_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
