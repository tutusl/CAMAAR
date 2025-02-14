FactoryBot.define do
    factory :resposta do
      valorResposta { Faker::Lorem.sentence }
      dataResposta { Time.current }
      association :usuario
      association :formulario
      association :questao
    end
end