FactoryBot.define do
    factory :departamento do
        sequence(:nomeDepartamento) { |n| "Departamento #{n}" }
    end
end