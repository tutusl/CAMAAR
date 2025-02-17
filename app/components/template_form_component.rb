# frozen_string_literal: true

# app/components/template_form_component.rb
class TemplateFormComponent < ViewComponent::Base
  def initialize(template:)
    @template = template || Template.new
  end

  def questoes_fields
    @template.questoes.map do |questao|
      render QuestionFieldsComponent.new(questao: questao)
    end
  end

  private

  def form_for
    simple_form_for @template do |f|
      concat f.input :nomeTemplate
      concat f.input :dataCriacao, as: :date
      concat f.input :semestre
      concat questoes_fields
      concat f.button :submit, class: 'btn btn-primary'
    end
  end
end
