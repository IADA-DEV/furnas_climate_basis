class CreateDataImportInmets < ActiveRecord::Migration[7.0]
  def change
    create_table :data_import_inmets do |t|
      t.date :dta_inicio
      t.date :dta_fim
      t.boolean :status
      t.belongs_to :inmet_weather_station, null: false

      t.timestamps
    end

    add_index :data_import_inmets, :status
   
  end
end
