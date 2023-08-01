class CreateLogErros < ActiveRecord::Migration[7.0]
  def change
    create_table :log_erros do |t|
      t.string :model
      t.text :description
      t.text :erro

      t.timestamps
    end
  end
end
