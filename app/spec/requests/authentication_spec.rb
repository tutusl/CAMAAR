require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let(:user) { create(:usuario) }

  describe 'POST /login' do
    context 'with valid credentials' do
      before do
        post login_path, params: { 
          session: { 
            email: user.email, 
            password: user.password 
          } 
        }
      end

      it 'sets user in session' do
        expect(session[:user_id]).to eq(user.id)
      end

      it 'redirects to dashboard' do
        expect(response).to redirect_to(root_path)
      end

      it 'sets welcome flash message' do
        expect(flash[:notice]).to match(/Login realizado com sucesso/)
      end
    end

    context 'with invalid credentials' do
      before do
        post login_path, params: { 
          session: { 
            email: 'wrong@email.com', 
            password: 'wrongpass' 
          } 
        }
      end

      it 'does not set user session' do
        expect(session[:user_id]).to be_nil
      end

      it 're-renders login form' do
        expect(response).to render_template(:new)
      end

      it 'shows error message' do
        expect(flash[:alert]).to match(/Invalid email or password/)
      end
    end
  end
end