class CreateQuestaos < ActiveRecord::Migration[6.0]
  def change
    create_table :questaos do |t|
      t.references :template, null: false, foreign_key: true
      t.text :enunciado, null: false
      t.string :tipoQuestao, null: false

      t.timestamps
    end
  end
end
