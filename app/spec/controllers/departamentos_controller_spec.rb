# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DepartamentosController, type: :controller do
  describe '#create' do
    let(:valid_departamentos_data) do
      [
        { nomeDepartamento: 'Ciência da Computação' },
        { nomeDepartamento: 'Engenharia Elétrica' }
      ]
    end

    context 'with valid data' do
      it 'creates departamentos successfully' do
        expect {
          post :create, params: { departamentos_data: valid_departamentos_data }
        }.to change(Departamento, :count).by(2)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('Departamentos criados com sucesso!')
      end
    end

    context 'with invalid data' do
      let(:invalid_departamentos_data) do
        [
          { nomeDepartamento: '' } # Invalid because nomeDepartamento is blank
        ]
      end

      it 'returns an error for invalid data' do
        expect {
          post :create, params: { departamentos_data: invalid_departamentos_data }
        }.not_to change(Departamento, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to include("Validation failed")
      end
    end

    context 'with empty departamentos_data' do
        let(:empty_departamentos_data) { [] }
        
        it 'does not create any departamentos' do
            expect {
            post :create, params: { departamentos_data: empty_departamentos_data }
            }.not_to change(Departamento, :count)
        
            expect(response).to have_http_status(:created)
            expect(JSON.parse(response.body)['message']).to eq('Departamentos criados com sucesso!')
        end
    end
    context 'with missing departamentos_data' do
        it 'does not create any departamentos' do
          expect {
            post :create, params: {}
          }.not_to change(Departamento, :count)
      
          expect(response).to have_http_status(:created)
          expect(JSON.parse(response.body)['message']).to eq('Departamentos criados com sucesso!')
        end
      end
  end
end