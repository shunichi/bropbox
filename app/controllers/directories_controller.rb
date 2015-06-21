class DirectoriesController < ApplicationController
  before_action :set_directory, only: %i(show edit update destroy move update copy share)
  before_action :set_parent_directory, only: %i(new create)

  def show
  end

  def new
    @directory = current_user.directories.build
  end

  def create
    @directory        = current_user.directories.build(directory_params)
    @directory.parent = @parent_directory
    respond_to do |format|
      if @directory.save
        format.html { redirect_to [@parent_directory], notice: "#{@directory.name} を作成しました" }
      else
        format.html { render 'new' }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def move
  end

  def copy
  end

  def share
  end

  private

  def set_directory
    @directory = current_user.directories.find(params[:id])
  end

  def set_parent_directory
    @parent_directory = current_user.directories.find(params[:parent_id])
  end

  def directory_params
    params.require(:directory).permit(:name)
  end
end
