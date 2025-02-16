FactoryBot.define do
    factory :formulario do
      dataCriacao { Time.current }
      tipoDestinatario { "aluno" }
      association :template
    end
end