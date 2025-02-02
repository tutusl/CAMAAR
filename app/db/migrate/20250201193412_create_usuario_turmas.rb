class CreateUsuarioTurmas < ActiveRecord::Migration[8.0]
  def change
    create_table :usuario_turmas do |t|
      t.references :turma, null: false, foreign_key: true
      t.references :usuario, null: false, foreign_key: true

      t.timestamps
    end

    add_index :usuario_turmas, [ :turma_id, :usuario_id ], unique: true
  end
end
