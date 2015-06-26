class SharedSubDirectoriesController < ApplicationController
  before_action :set_shared_root_directory, :set_directory, only: %i(show)

  def show
  end

  private

  def set_shared_root_directory
    @root_directory = current_user.shared_directories.find(params[:shared_directory_id])
  end

  def set_directory
    @directory = @root_directory.directory if Directory.find(params[:id]).id == @root_directory.id
    @directory ||= @root_directory.directory.subtree.find(params[:id])
  end
end
