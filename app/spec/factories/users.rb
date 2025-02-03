FactoryBot.define do
  factory :usuario, class: 'Usuario' do # Note a referência explícita à classe
    nome { "Admin" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "admin123" }
    password_confirmation { "admin123" }
    sequence(:matricula) { |n| "0000#{n.to_s.rjust(4, '0')}" }
    papel { "administrador" }
    formacao { "doutorado" }
    departamento { create(:departamento) } # Ajuste se necessário
  end
end