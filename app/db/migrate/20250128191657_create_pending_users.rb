class CreatePendingUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :pending_users do |t|
      t.string :nome
      t.string :email
      t.string :matricula
      t.string :curso
      t.string :departamento
      t.string :papel
      t.string :formacao
      t.string :token
      t.datetime :token_created_at

      t.timestamps
    end
  end
end
