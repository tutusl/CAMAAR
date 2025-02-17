# frozen_string_literal: true

class FormulariosController < ApplicationController

  def index
    @formularios = Formulario.all
  end

  def new
    @templates = Template.all # Carrega todos os templates disponíveis
    @formulario = Formulario.new
  end

  def create
    @formulario = Formulario.new(formulario_params)
    @formulario.dataCriacao = Time.current

    if @formulario.save
      redirect_to formularios_path, notice: 'Formulário criado com sucesso!'
    else
      @templates = Template.all
      render :new
    end
  end

  def show
    @formulario = Formulario.find(params[:id])
    @template = @formulario.template
    @questaos = @template.questaos
    @respostas = @formulario.respostas
  end

  private

  def formulario_params
    params.require(:formulario).permit(:template_id, :tipoDestinatario)
  end
end