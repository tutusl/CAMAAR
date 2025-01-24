class CreateTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :templates do |t|
      t.string :nomeTemplate, null: false
      t.datetime :dataCriacao, null: false
      t.string :semestre, null: false

      t.timestamps
    end
  end
end
