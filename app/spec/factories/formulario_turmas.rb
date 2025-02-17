# frozen_string_literal: true

FactoryBot.define do
  factory :formulario_turma do
    association :turma
    association :formulario
  end
end
