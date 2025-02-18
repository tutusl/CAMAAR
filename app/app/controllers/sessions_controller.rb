# Controller responsible for handling user session management (login/logout functionality)
class SessionsController < ApplicationController
  # Skips the login requirement for creating new sessions and viewing the login form
  skip_before_action :require_login, only: [ :create, :new ]

  # Renders the login form
  #
  # @note This action doesn't receive any arguments
  # @return [void]
  # @side_effects Renders the new session view template
  def new
  end

  # Authenticates user credentials and creates a new session
  #
  # @note Processes the login form submission
  # @param email [String] User's email address (received via params)
  # @param password [String] User's password (received via params)
  # @return [void]
  # @side_effects 
  #   - Creates a new session with user_id if authentication succeeds
  #   - Redirects to respostas_path if user is an administrator
  #   - Redirects to avaliacoes_path if user is not an administrator
  #   - Sets flash notice and redirects to login form if authentication fails
  def create
    @usuario = Usuario.find_by(email: session_params[:email])
    if @usuario && @usuario.authenticate(session_params[:password])
      session[:user_id] = @usuario.id
      # Redireciona com base no tipo de usuário
      if @usuario.papel == "administrador"
        redirect_to respostas_path
      else
        redirect_to avaliacoes_path
      end
    else
      flash[:notice] = "Login inválido!"
      redirect_to new_session_path
    end
  end

  # Terminates the current user session (logs out the user)
  #
  # @note This action doesn't receive any arguments
  # @return [void]
  # @side_effects 
  #   - Clears the user_id from session
  #   - Sets a success flash notice
  #   - Redirects to the login form
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logout feito com sucesso!"
    redirect_to new_session_path
  end

  private

  # Permits and filters session-related parameters
  #
  # @note Used internally by the create action
  # @return [ActionController::Parameters] Filtered parameters containing :email and :password
  # @side_effects None
  def session_params
    params.permit(:email, :password)
  end
end
