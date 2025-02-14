FactoryBot.define do
    factory :formulario_turma do
      association :turma
      association :formulario
    end
end