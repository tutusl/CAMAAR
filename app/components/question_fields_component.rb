# frozen_string_literal: true

# app/components/question_fields_component.rb
class QuestionFieldsComponent < ViewComponent::Base
  def initialize(questao:)
    @questao = questao || Questao.new
  end

  private

  def question_fields
    simple_fields_for :questoes, @questao do |q|
      concat q.input :tipo, collection: ['Múltipla escolha', 'Dissertativa']
      concat q.input :enunciado
      concat q.button_tag 'Remover', type: 'button', class: 'btn btn-danger',
                                     data: { action: 'click->template-form#removeQuestion' }
    end
  end
end
