FactoryBot.define do
    factory :usuario do
      sequence(:matricula) { |n| "2023000#{n}" }
      nome { Faker::Name.name }
      sequence(:email) { |n| "user#{n}@example.com" }
      password { "password123" }
      password_confirmation { "password123" }
      formacao { Faker::Educator.degree }
      
      association :curso, factory: :curso
      association :departamento
  
      trait :aluno do
        papel { "aluno" }
      end
  
      trait :professor do
        papel { "professor" }
      end
  
      trait :administrador do
        papel { "administrador" }
        curso { nil }
      end
    end
end