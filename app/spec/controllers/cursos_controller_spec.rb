# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CursosController, type: :controller do
  let(:departamento) { create(:departamento, nomeDepartamento: 'Ciência da Computação') }
  let(:usuario) { create(:usuario, :administrador) } # Assuming an admin role is required

  before { sign_in(usuario) }

  describe '#create' do
    let(:valid_cursos_data) do
      [
        { nomeCurso: 'Engenharia de Software', nomeDepartamento: departamento.nomeDepartamento },
        { nomeCurso: 'Inteligência Artificial', nomeDepartamento: departamento.nomeDepartamento }
      ]
    end

    context 'with valid data' do
      it 'creates cursos successfully' do
        expect {
          post :create, params: { cursos_data: valid_cursos_data }
        }.to change(Curso, :count).by(2)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('Cursos criados com sucesso!')
      end
    end

    context 'with invalid departamento' do
      let(:invalid_cursos_data) do
        [
          { nomeCurso: 'Engenharia de Software', nomeDepartamento: 'Departamento Inexistente' }
        ]
      end

      it 'returns an error for missing departamento' do
        expect {
          post :create, params: { cursos_data: invalid_cursos_data }
        }.not_to change(Curso, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to include('Departamento não encontrado')
      end
    end

    context 'with invalid curso data' do
      let(:invalid_curso_data) do
        [
          { nomeCurso: '', nomeDepartamento: departamento.nomeDepartamento } # Invalid because nomeCurso is blank
        ]
      end

      it 'returns an error for invalid curso data' do
        expect {
          post :create, params: { cursos_data: invalid_curso_data }
        }.not_to change(Curso, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to include("Validation failed")
      end
    end
  end
end