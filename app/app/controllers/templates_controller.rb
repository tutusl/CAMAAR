# frozen_string_literal: true

class TemplatesController < ApplicationController
  def index
    # render layout: false
    @templates = Template.all
  end

  def new
    @template = Template.new
    @template.questaos.build
  end

  def create
    puts "Params recebidos: #{params.inspect}"

    @template = Template.new(template_params)
    @template.dataCriacao = Time.current

    if @template.questaos.is_a?(Hash) # Evita o erro ao tentar iterar sobre um hash
      puts 'questaos não está no formato esperado, ajustando...'
      @template.questaos = @template.questaos.map { |q| Questao.new(q) }
    end

    # @template.questaos.each { |q| q.tipo = "Dissertativa" } if @template.questaos.any?

    if @template.save
      redirect_to templates_path, notice: 'Template criado com sucesso!'
    else
      puts "Erros ao salvar: #{@template.errors.full_messages}"
      redirect_to new_template_path, alert: @template.errors.full_messages.join(', ')
    end
  end

  private

  def template_params
    params.require(:template).permit(
      :nomeTemplate,
      :dataCriacao,
      :semestre,
      questaos_attributes: %i[id enunciado tipoQuestao _destroy]
    )
  end
end
