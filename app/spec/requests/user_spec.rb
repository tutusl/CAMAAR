require'rails_helper'

RSpec.describe "Usuarios", type: :request do
  describe"POST /usuarios" do
    context "Parametros validos" do
      it "Cria um usuário" do
        expect{
          post "/usuarios", params: {
            usuario: {
              matricula: "12345678",
              nome: "Julia",
              email: "teste@exemplo.com",
              password: "teste",
              password_confirmation: "teste",
              papel: "discente",
              formacao: "engenharia",
              departamento_id: "3"
            }
          }
        }.to change(Usuario, :count).by(1)

        expect(response).to have_http_status(:redirect) # Código 302
        expect(response).to redirect_to(usuario_path(Usuario.last)) # Redireciona para a página do novo usuário
      end
    end
  end
end