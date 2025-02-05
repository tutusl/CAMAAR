class CreateCursos < ActiveRecord::Migration[7.0]
  def change
    create_table :cursos do |t|
      t.string :nomeCurso, null: false
      t.references :departamento, null: false, foreign_key: true

      t.timestamps
    end
  end
end


