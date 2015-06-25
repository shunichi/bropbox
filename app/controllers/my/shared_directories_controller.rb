class My::SharedDirectoriesController < ApplicationController
  before_action :set_directory
  before_action :set_shared_directory, only: %i(destroy)

  def index
    @shared_directories = @directory.shared_directories
  end

  def new
    @shared_directory = @directory.shared_directories.build
  end

  def create
    @shared_directory = @directory.shared_directories.build(shared_directory_params)
    respond_to do |format|
      if @shared_directory.save
        format.html { redirect_to [:my, @directory, :shared_directories], notice: '共有しました' }
      else
        format.html { render 'new' }
      end
    end
  end

  def destroy
    @shared_directory.destroy
    redirect_to [:my, @directory, :shared_directories], notice: '共有を解除しました'
  end

  private

  def set_directory
    @directory = current_user.directories.find(params[:directory_id])
  end

  def set_shared_directory
    @shared_directory = @directory.shared_directories.find(params[:id])
  end

  def shared_directory_params
    return {} if params[:shared_directory].blank?
    params.require(:shared_directory).permit(:user_id)
  end
end
