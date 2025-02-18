# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:aluno) { create(:usuario, :aluno, password: 'password123') }
  let(:administrador) { create(:usuario, :administrador, password: 'password123') }

  describe 'GET #new' do
    it 'renders the login template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      context 'when user is an aluno' do
        it 'logs in the user and redirects to formularios_path' do
          post :create, params: { email: aluno.email, password: 'password123' }
          expect(session[:user_id]).to eq(aluno.id)
          expect(response).to redirect_to(formularios_path)
        end
      end

      context 'when user is an administrador' do
        it 'logs in the user and redirects to respostas_path' do
          post :create, params: { email: administrador.email, password: 'password123' }
          expect(session[:user_id]).to eq(administrador.id)
          expect(response).to redirect_to(respostas_path)
        end
      end
    end

    context 'with invalid credentials' do
      it 're-renders the login page' do
        post :create, params: { email: aluno.email, password: 'wrongpass' }
        expect(response).to redirect_to(new_session_path)
      end

      it 'sets a flash notice for invalid login' do
        post :create, params: { email: aluno.email, password: 'wrongpass' }
        expect(flash[:notice]).to match(/Login inválido/)
      end
    end

    context 'with missing parameters' do
      it 're-renders the login page when email is missing' do
        post :create, params: { password: 'password123' }
        expect(response).to redirect_to(new_session_path)
      end

      it 're-renders the login page when password is missing' do
        post :create, params: { email: aluno.email }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { sign_in aluno }

    it 'logs out the user by clearing the session' do
      delete :destroy, params: { id: aluno.id }
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the login page' do
      delete :destroy, params: { id: aluno.id }
      expect(response).to redirect_to(new_session_path)
    end

    it 'sets a flash notice for successful logout' do
      delete :destroy, params: { id: aluno.id }
      expect(flash[:notice]).to match(/Logout feito com sucesso/)
    end
  end
end