# frozen_string_literal: true

FactoryBot.define do
  factory :turma do
    sequence(:codigoTurma) { |n| "TURMA#{n}" }
    semestre { '2023.1' }
    horario { '08:00-10:00' }
    association :disciplina, factory: :disciplina
  end
end
