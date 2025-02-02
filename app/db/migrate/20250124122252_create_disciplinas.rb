class CreateDisciplinas < ActiveRecord::Migration[8.0]
  def change
    create_table :disciplinas, id: false do |t|
      t.string :codigoDisciplina, null: false, primary_key: true
      t.references :departamento, null: false, foreign_key: true
      t.string :nomeDisciplina, null: false

      t.timestamps
    end
  end
end
