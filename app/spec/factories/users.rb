# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      nome { Faker::Name.name }
      sequence(:email) { |n| "user#{n}@example.com" }
      sequence(:matricula) { |n| "0000#{n.to_s.rjust(4, '0')}" }
      papel { %w[discente docente administrador].sample }
      formacao { %w[graduando mestrado doutorado].sample }
      departamento { Faker::Educator.university }
      curso { Faker::Educator.course_name }
  
      # Traits para papéis específicos
      trait :discente do
        papel { 'discente' }
        formacao { 'graduando' }
      end
  
      trait :docente do
        papel { 'docente' }
        formacao { 'doutorado' }
      end
  
      trait :administrador do
        papel { 'administrador' }
        formacao { nil }
        curso { nil }
      end
    end
  end