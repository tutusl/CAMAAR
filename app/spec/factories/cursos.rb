# frozen_string_literal: true

FactoryBot.define do
  factory :curso do
    sequence(:nomeCurso) { |n| "Curso #{n}" }
    association :departamento
  end
end
