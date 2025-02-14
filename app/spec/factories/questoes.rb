FactoryBot.define do
    factory :questao do
      enunciado { Faker::Lorem.question }
      tipoQuestao { "multipla_escolha" }
      association :template
    end
end