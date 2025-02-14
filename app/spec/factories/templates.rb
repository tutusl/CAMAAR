FactoryBot.define do
    factory :template do
      sequence(:nomeTemplate) { |n| "Template #{n}" }
      dataCriacao { Time.current }
      semestre { "2023.1" }
    end
end