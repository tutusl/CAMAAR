# frozen_string_literal: true

FactoryBot.define do
  factory :usuario_turma do
    association :usuario
    association :turma
  end
end
