FactoryBot.define do
    factory :disciplina do
      sequence(:codigoDisciplina) { |n| "DISC#{n}" }
      nomeDisciplina { Faker::Educator.course_name }
      association :departamento
    end
end