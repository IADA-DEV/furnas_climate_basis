class CreateSyestemConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :syestem_configs do |t|
      t.string :cdg_station, default: 'A002'
      t.boolean :status_menu, default: true
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
