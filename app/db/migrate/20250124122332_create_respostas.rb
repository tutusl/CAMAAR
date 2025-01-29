class CreateRespostas < ActiveRecord::Migration[6.0]
  def change
    create_table :respostas do |t|
      t.references :usuario, null: false, foreign_key: true
      t.references :formulario, null: false, foreign_key: true
      t.references :questao, null: false, foreign_key: true
      t.datetime :dataResposta, null: false
      t.text :valorResposta, null: false

      t.timestamps
    end
  end
end
