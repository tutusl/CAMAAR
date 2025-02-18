# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TemplatesController, type: :controller do
  let(:usuario) { create(:usuario, :administrador) } # Cria um usuário autenticado

  before do
    sign_in usuario # Faz login do usuário antes de cada teste
  end

  let(:valid_attributes) do
    {
      nomeTemplate: 'Template de Exemplo',
      dataCriacao: Time.current,
      semestre: '2023.1',
      questaos_attributes: [
        { enunciado: 'Questão 1', tipoQuestao: 'Dissertativa' },
        { enunciado: 'Questão 2', tipoQuestao: 'Múltipla Escolha' }
      ]
    }
  end

  let(:invalid_attributes) do
    {
      nomeTemplate: '',
      dataCriacao: nil,
      semestre: ''
    }
  end

  describe 'GET #index' do
    it 'retorna uma resposta bem-sucedida' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'retorna uma resposta bem-sucedida' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'com parâmetros válidos' do
      it 'cria um novo Template' do
        expect {
          post :create, params: { template: valid_attributes }
        }.to change(Template, :count).by(1)
      end

      it 'redireciona para a lista de templates' do
        post :create, params: { template: valid_attributes }
        expect(response).to redirect_to(templates_path)
      end
    end

    context 'com parâmetros inválidos' do
      it 'não cria um novo Template' do
        expect {
          post :create, params: { template: invalid_attributes }
        }.not_to change(Template, :count)
      end

      it 'renderiza o formulário de novo template' do
        post :create, params: { template: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'retorna uma resposta bem-sucedida' do
      template = Template.create! valid_attributes
      get :edit, params: { id: template.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) do
      {
        nomeTemplate: 'Template Atualizado',
        semestre: '2023.2'
      }
    end

    context 'com parâmetros válidos' do
      it 'atualiza o Template solicitado' do
        template = Template.create! valid_attributes
        put :update, params: { id: template.to_param, template: new_attributes }
        template.reload
        expect(template.nomeTemplate).to eq('Template Atualizado')
        expect(template.semestre).to eq('2023.2')
      end

      it 'redireciona para a lista de templates' do
        template = Template.create! valid_attributes
        put :update, params: { id: template.to_param, template: new_attributes }
        expect(response).to redirect_to(templates_path)
      end
    end

    context 'com parâmetros inválidos' do
      it 'não atualiza o Template' do
        template = Template.create! valid_attributes
        put :update, params: { id: template.to_param, template: invalid_attributes }
        template.reload
        expect(template.nomeTemplate).not_to eq('')
      end

      it 'renderiza o formulário de edição' do
        template = Template.create! valid_attributes
        put :update, params: { id: template.to_param, template: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'exclui o Template solicitado' do
      template = Template.create! valid_attributes
      expect {
        delete :destroy, params: { id: template.to_param }
      }.to change(Template, :count).by(-1)
    end

    it 'redireciona para a lista de templates' do
      template = Template.create! valid_attributes
      delete :destroy, params: { id: template.to_param }
      expect(response).to redirect_to(templates_path)
    end
  end
end
