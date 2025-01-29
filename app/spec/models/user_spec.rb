require 'rails_helper'

RSpec.describe Usuario, type: :model do
  it "Cria um usuário" do
    usuario = Usuario.new(matricula: "0123456789", nome: "Joao", email: "email@exemplo.com",
                       password: "senha123", password_confirmation: "senha123", papel: "Discente",
                       formacao: "Graduando", departamento_id: "3")
    expect(usuario).to be_valid 
  end
end
