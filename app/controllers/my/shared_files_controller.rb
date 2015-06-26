class My::SharedFilesController < ApplicationController
  before_action :set_file
  before_action :set_shared_file, only: %i(destroy)

  def index
    @shared_files = @file.shared_files
  end

  def new
    @shared_file = @file.shared_files.build
  end

  def create
    @shared_file = @file.shared_files.build(shared_file_params)
    respond_to do |format|
      if @shared_file.save
        format.html { redirect_to [:my, @file, :shared_files], notice: '共有しました' }
      else
        format.html { render 'new' }
      end
    end
  end

  def destroy
    @shared_file.destroy
    redirect_to [:my, @file, :shared_files], notice: '共有を解除しました'
  end

  private

  def set_file
    @file = current_user.files.find(params[:fileitem_id])
  end

  def set_shared_file
    @shared_file = @file.shared_files.find(params[:id])
  end

  def shared_file_params
    return {} if params[:shared_file].blank?
    params.require(:shared_file).permit(:user_id)
  end
end
