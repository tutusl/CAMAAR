class CreateCursos < ActiveRecord::Migration[6.0]
  def change
    create_table :cursos do |t|
      t.string :nomeCurso, null: false

      t.timestamps
    end
  end
end
