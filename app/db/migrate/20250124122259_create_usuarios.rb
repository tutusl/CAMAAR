class CreateUsuarios < ActiveRecord::Migration[8.0]
  def change
    create_table :usuarios do |t|
      t.string :matricula, null: false
      t.references :curso, null: true, foreign_key: true
      t.references :departamento, null: false, foreign_key: true
      t.string :nome, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :papel, null: false
      t.string :formacao, null: false

      t.timestamps
    end

    # Adiciona índices únicos para as colunas necessárias
    add_index :usuarios, :matricula, unique: true
    add_index :usuarios, :email, unique: true
  end
end
