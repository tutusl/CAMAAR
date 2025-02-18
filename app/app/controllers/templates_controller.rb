# frozen_string_literal: true

# Controller responsible for managing Templates and their associated Questions (CRUD operations)
class TemplatesController < ApplicationController
  # Lists all available templates
  #
  # @return [void]
  # @side_effects
  #   - Assigns @templates instance variable with all Template records
  #   - Renders the index view template
  def index
    # render layout: false
    @templates = Template.all
  end

  # Displays the form for creating a new template
  #
  # @return [void]
  # @side_effects
  #   - Creates a new Template instance
  #   - Builds an empty associated question
  #   - Renders the new template form
  def new
    @template = Template.new
    @template.questaos.build
  end

  # Creates a new template with its associated questions
  #
  # @note Processes the template creation form submission
  # @param template [Hash] Template attributes including nested question attributes
  # @return [void]
  # @side_effects
  #   - Creates a new Template record in the database
  #   - Sets the creation date to current time
  #   - Creates associated Question records
  #   - Redirects to templates index with success notice on success
  #   - Redirects to new template form with error alert on failure
  #   - Logs parameters and errors for debugging
  def create
    puts "Params recebidos: #{params.inspect}"
    @template = Template.new(template_params)
    @template.dataCriacao = Time.current

    if @template.questaos.is_a?(Hash)
      puts 'questaos não está no formato esperado, ajustando...'
      @template.questaos = @template.questaos.map { |q| Questao.new(q) }
    end

    if @template.save
      redirect_to templates_path, notice: 'Template criado com sucesso!'
    else
      puts "Erros ao salvar: #{@template.errors.full_messages}"
      redirect_to new_template_path, alert: @template.errors.full_messages.join(', ')
    end
  end

  # Displays the form for editing an existing template
  #
  # @param id [Integer] The ID of the template to edit
  # @return [void]
  # @side_effects
  #   - Finds and assigns the template to @template
  #   - Renders the edit template form
  def edit
    @template = Template.find(params[:id])
  end

  # Updates an existing template and its associated questions
  #
  # @param id [Integer] The ID of the template to update
  # @param template [Hash] Updated template attributes including nested question attributes
  # @return [void]
  # @side_effects
  #   - Updates the Template record in the database
  #   - Updates associated Question records
  #   - Redirects to templates index with success notice on success
  #   - Re-renders edit form on failure
  #   - Logs errors for debugging
  def update
    @template = Template.find(params[:id])
    if @template.update(template_params)
      redirect_to templates_path, notice: 'Template atualizado com sucesso!'
    else
      puts "Erros ao atualizar: #{@template.errors.full_messages}"
      render :edit
    end
  end

  # Deletes a template and all its associated questions
  #
  # @param id [Integer] The ID of the template to delete
  # @return [void]
  # @side_effects
  #   - Deletes all associated Question records
  #   - Deletes the Template record
  #   - Redirects to templates index with success notice
  def destroy
    @template = Template.find(params[:id])
    @template.questaos.destroy_all # Exclui todas as questões associadas
    @template.destroy
    redirect_to templates_path, notice: 'Template excluído com sucesso!'
  end

  private

  # Filters and permits template parameters for mass assignment
  #
  # @return [ActionController::Parameters] Filtered parameters containing template attributes
  #   and nested question attributes
  # @side_effects None
  def template_params
    params.require(:template).permit(
      :nomeTemplate,
      :dataCriacao,
      :semestre,
      questaos_attributes: %i[id enunciado tipoQuestao _destroy]
    )
  end
end
