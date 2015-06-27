class Public::DirectoriesController < Public::ApplicationController
  before_action :set_access_token_into_session, :set_publicate_directory, :set_directory, :check_access_token, only: %i(show)

  def show
  end

  private

  def set_publicate_directory
    @publicate_directory = PublicateDirectory.find(params[:id])
  end

  def set_directory
    @directory = @publicate_directory.directory
  end

  def check_access_token
    return head(:bad_request) if @publicate_directory.access_token != session[:access_token]
  end

  def set_access_token_into_session
    reset_session
    session[:access_token] = params[:access_token]
  end
end
