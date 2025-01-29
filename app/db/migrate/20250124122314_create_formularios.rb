class CreateFormularios < ActiveRecord::Migration[6.0]
  def change
    create_table :formularios do |t|
      t.references :template, null: false, foreign_key: true
      t.datetime :dataCriacao, null: false
      t.string :tipoDestinatario, null: false

      t.timestamps
    end
  end
end
