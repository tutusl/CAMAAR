# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:usuario, :aluno, password: 'password123') }

  describe 'GET #new' do
    it 'renders the login template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'logs in the user' do
        post :create, params: { session: { email: user.email, password: 'password123' } }
        expect(session[:user_id]).to eq(user.id)
      end

      it 'redirects to dashboard' do
        post :create, params: { session: { email: user.email, password: 'password123' } }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid credentials' do
      it 're-renders login page' do
        post :create, params: { session: { email: user.email, password: 'wrongpass' } }
        expect(response).to render_template(:new)
      end

      it 'sets flash error message' do
        post :create, params: { session: { email: user.email, password: 'wrongpass' } }
        expect(flash[:alert]).to match(/Invalid email or password/)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { sign_in user }

    it 'logs out the user' do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to login page' do
      delete :destroy
      expect(response).to redirect_to(login_path)
    end
  end
end
