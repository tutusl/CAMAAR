# spec/factories/participantes.rb
FactoryBot.define do
    factory :participante do
      association :turma
      association :user
  
      # Para diferenciar docentes e discentes
      trait :docente do
        user { create(:user, :docente) }
      end
  
      trait :discente do
        user { create(:user, :discente) }
      end
    end
  end