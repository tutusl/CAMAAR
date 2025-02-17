# frozen_string_literal: true

FactoryBot.define do
  factory :departamento do
    sequence(:nomeDepartamento) { |n| "Departamento #{n}" }
  end
end
