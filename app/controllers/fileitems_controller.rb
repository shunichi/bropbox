class FileitemsController < ApplicationController
  before_action :set_directory
  before_action :build_new_file, only: %i(new create)
  before_action :set_file, only: %i(show edit update destroy move update copy share)

  def show
  end

  def new
  end

  def create
    @file.bindata = params[:fileitem][:bindata].read
    @file.name    = params[:fileitem][:bindata].original_filename
    respond_to do |format|
      if @file.save
        format.html { redirect_to [@file.directory], notice: "#{@file.name} をアップロードしました" }
      else
        format.html { render 'new' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @file.update(file_params)
        format.html { redirect_to [@file.directory], notice: 'ファイル名を変更しました' }
      else
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    @file.destroy
    redirect_to [@file.directory], notice: 'ファイルを削除しました'
  end

  def move
  end

  def copy
  end

  def share
  end

  private

  def set_directory
    @directory = current_user.directories.find(params[:directory_id])
  end

  def build_new_file
    @file = @directory.files.build
  end

  def set_file
    @file = @directory.files.find(params[:id])
  end

  def file_params
    params.require(:fileitem).permit(:name)
  end
end
