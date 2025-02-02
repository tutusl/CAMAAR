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
    Usuario.create!(
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

[ "Departamento de Ciências da Computação", "Departamento de Engenharia Elétrica",
  "Departamento de Engenharia Mecânica", "Departamento de Administração", "Departamento de Economia",
  "Departamento de Matemática", "Faculdade de Direito", "Faculdade de Medicina", "Departamento de Engenharia Civil e Ambiental"
  ].each do |departamento|
    Departamento.find_or_create_by!(nomeDepartamento: departamento)
  end

[
  {
    "nomeCurso": "CIÊNCIA DA COMPUTAÇÃO/CIC",
    "nomeDepartamento": "Departamento de Ciências da Computação"
  }, {
    "nomeCurso": "ENGENHARIA DE COMPUTAÇÃO/CIC",
    "nomeDepartamento": "Departamento de Ciências da Computação"
  },
  {
    "nomeCurso": "ENGENHARIA ELÉTRICA/ENE",
    "nomeDepartamento": "Departamento de Engenharia Elétrica"
  },
  {
    "nomeCurso": "ENGENHARIA MECATRÔNICA/FT",
    "nomeDepartamento": "Departamento de Engenharia Mecânica"
  },
  {
    "nomeCurso": "ADMINISTRAÇÃO/FACE",
    "nomeDepartamento": "Departamento de Administração"
  },
  {
    "nomeCurso": "ECONOMIA/FACE",
    "nomeDepartamento": "Departamento de Economia"
  },
  {
    "nomeCurso": "MATEMÁTICA/EST",
    "nomeDepartamento": "Departamento de Matemática"
  },
  {
    "nomeCurso": "ENGENHARIA CIVIL/ENC",
    "nomeDepartamento": "Departamento de Engenharia Civil e Ambiental"
  },
  {
    "nomeCurso": "DIREITO/FD",
    "nomeDepartamento": "Faculdade de Direito"
  },
  {
    "nomeCurso": "MEDICINA/FM",
    "nomeDepartamento": "Faculdade de Medicina"
  }
].each do |curso|
    nome_curso = curso[:nomeCurso]
    nome_departamento = curso[:nomeDepartamento]
    departamento = Departamento.find_by(nomeDepartamento: nome_departamento)
    if departamento.present?
      Curso.find_or_create_by!(nomeCurso: nome_curso, departamento_id: departamento.id)
    else
      puts "Erro: Departamento não encontrado para o curso #{nome_curso}"
    end
end
