# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsuariosController, type: :controller do
  let(:usuario) { create(:usuario) } # Cria um usuário autenticado
  let(:valid_attributes) do
    {
      matricula: '123456',
      nome: 'João Silva',
      email: 'joao@example.com',
      password: 'password123',
      password_confirmation: 'password123',
      papel: 'professor',
      formacao: 'Doutorado',
      departamento_id: create(:departamento).id,
      curso_id: create(:curso).id
    }
  end

  let(:invalid_attributes) do
    {
      matricula: '',
      nome: '',
      email: 'email_invalido',
      password: 'short',
      password_confirmation: 'mismatch',
      papel: '',
      formacao: ''
    }
  end

  before do
    sign_in usuario # Garante que o usuário está autenticado
  end

  describe 'GET #edit' do
    it 'retorna uma resposta bem-sucedida' do
      usuario = create(:usuario)
      sign_in usuario
      get :edit, params: { id: usuario.to_param }
      expect(response).to be_successful
    end

    it 'atribui o usuário correto à variável @usuario' do
      usuario = create(:usuario)
      sign_in usuario
      get :edit, params: { id: usuario.to_param }
      expect(assigns(:usuario)).to eq(usuario)
    end
  end

  describe 'PUT #update' do
    context 'com parâmetros válidos' do
      it 'atualiza o usuário corretamente' do
        usuario = create(:usuario)
        sign_in usuario
        put :update, params: { id: usuario.to_param, usuario: { nome: 'Novo Nome' } }
        usuario.reload
        expect(usuario.nome).to eq('Novo Nome')
      end

      it 'redireciona para a página do usuário com sucesso' do
        usuario = create(:usuario)
        sign_in usuario
        put :update, params: { id: usuario.to_param, usuario: { nome: 'Novo Nome' } }
        expect(response).to redirect_to(usuario)
        expect(flash[:notice]).to eq('Usuário atualizado com sucesso.')
      end
    end

    context 'com parâmetros inválidos' do
      it 'não atualiza o usuário' do
        usuario = create(:usuario)
        sign_in usuario
        put :update, params: { id: usuario.to_param, usuario: { email: 'email_invalido' } }
        usuario.reload
        expect(usuario.email).not_to eq('email_invalido')
      end

      it 'renderiza o formulário de edição novamente' do
        usuario = create(:usuario)
        sign_in usuario
        put :update, params: { id: usuario.to_param, usuario: { email: 'email_invalido' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'exclui o usuário' do
      usuario = create(:usuario)
      sign_in usuario
      expect {
        delete :destroy, params: { id: usuario.to_param }
      }.to change(Usuario, :count).by(-1)
    end

    it 'redireciona para a lista de usuários com sucesso' do
      usuario = create(:usuario)
      sign_in usuario
      delete :destroy, params: { id: usuario.to_param }
      expect(response).to redirect_to(usuarios_path)
      expect(flash[:notice]).to eq('Usuário excluído com sucesso.')
    end
  end

  describe 'POST #alterar_senha' do
    it 'envia um e-mail para alteração de senha' do
      usuario = create(:usuario)
      sign_in usuario
      expect {
        post :alterar_senha, params: { id: usuario.to_param }
      }.to have_enqueued_job(ActionMailer::MailDeliveryJob)
      expect(flash[:notice]).to eq('Um e-mail foi enviado para redefinir sua senha.')
    end
  end
end