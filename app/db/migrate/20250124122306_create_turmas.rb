class CreateTurmas < ActiveRecord::Migration[8.0]
  def change
    create_table :turmas do |t|
      t.string :codigoTurma, null: false
      t.string :codigoDisciplina, null: false
      t.string :semestre, null: false
      t.string :horario, null: false

      t.foreign_key :disciplinas, column: :codigoDisciplina, primary_key: :codigoDisciplina

      t.timestamps
    end

    add_index :turmas, :codigoTurma, unique: true
  end
end
