class CreateFormularioTurmas < ActiveRecord::Migration[8.0]
  def change
    create_table :formulario_turmas do |t|
      t.references :turma, null: false, foreign_key: true
      t.references :formulario, null: false, foreign_key: true

      t.timestamps
    end

    # Adiciona um índice único para evitar duplicatas na combinação de turma e formulário
    add_index :formulario_turmas, [ :turma_id, :formulario_id ], unique: true
  end
end
