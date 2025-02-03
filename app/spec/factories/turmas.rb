# spec/factories/turmas.rb
FactoryBot.define do
    factory :turma do
      code { "CIC#{Faker::Number.unique.number(digits: 4)}" }
      name { Faker::Educator.course }
      class_code { "TA" }
      semester { "2021.2" }
      time { "35T45" }
    end
  end