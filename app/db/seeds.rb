# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Primeiro, cria um departamento padrão se não existir
departamento_admin = Departamento.find_or_create_by!(nomeDepartamento: 'Administração') do |dept|
    puts 'Criando departamento padrão...'
  end
  
  # Depois, cria o usuário admin
  unless Usuario.exists?(email: 'admin@admin')
    admin = Usuario.create!(
      email: 'admin@admin',
      password: 'admin',
      password_confirmation: 'admin', 
      papel: 'administrador',        
      nome: 'Administrador',
      matricula: 'ADM001',          
      formacao: 'Administração',
      departamento_id: departamento_admin.id
    )
    
    puts 'Administrador padrão criado com sucesso!'
    puts 'Email: admin@admin'
    puts 'Senha: admin'
  else
    puts 'Administrador padrão já existe.'
  end