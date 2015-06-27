class Public::SubDirectoriesController < Public::ApplicationController
  before_action :set_root_publicate_directory, :set_directory, only: %i(show)

  def show
    render 'public/directories/show'
  end

  private

  def set_root_publicate_directory
    @root_publicate_directory = PublicateDirectory.find_by!(access_token: session[:access_token])
  end

  def set_directory
    @directory = @root_publicate_directory.directory.subtree.find(params[:id])
  end
end
