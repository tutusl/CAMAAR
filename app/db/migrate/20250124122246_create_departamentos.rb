class CreateDepartamentos < ActiveRecord::Migration[6.0]
  def change
    create_table :departamentos do |t|
      t.string :nomeDepartamento, null: false

      t.timestamps
    end
  end
end
