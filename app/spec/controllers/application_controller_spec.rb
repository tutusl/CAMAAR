require 'rails_helper'

class DummyController < ApplicationController
  def index
    render plain: 'Success'
  end
end

RSpec.describe ApplicationController, type: :controller do
  describe '#require_login' do
    controller(DummyController) do
      # The dummy controller inherits from ApplicationController
    end

    context 'when the user is not logged in' do
      it 'redirects to the login page' do
        get :index
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when the user is logged in' do
      let(:usuario) { create(:usuario, :aluno) }

      before { sign_in(usuario) }

      it 'allows access to the action' do
        get :index
        expect(response.body).to eq('Success')
      end
    end
  end

  describe '#current_user' do
    controller(DummyController) do
      # The dummy controller inherits from ApplicationController
    end

    context 'when the user is logged in' do
      let(:usuario) { create(:usuario, :aluno) }

      before { sign_in(usuario) }

      it 'returns the current user' do
        get :index
        expect(controller.current_user).to eq(usuario)
      end
    end

    context 'when the user is not logged in' do
      it 'returns nil' do
        get :index
        expect(controller.current_user).to be_nil
      end
    end
  end
end