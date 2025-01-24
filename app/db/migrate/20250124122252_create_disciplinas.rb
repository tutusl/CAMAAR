class CreateDisciplinas < ActiveRecord::Migration[8.0]
  def change
    create_table :disciplinas, id: false, primary_key: "codigoDisciplina" do |t|
      t.string :codigoDisciplina, null: false
      t.references :departamento, null: false, foreign_key: true
      t.string :nomeDisciplina, null: false

      t.timestamps
    end

    add_index :disciplinas, :codigoDisciplina, unique: true
  end
end
