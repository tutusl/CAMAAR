# frozen_string_literal: true

FactoryBot.define do
  factory :formulario do
    dataCriacao { Time.current }
    tipoDestinatario { 'aluno' }
    association :template
  end
end
