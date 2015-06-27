class My::PublicateDirectoriesController < ApplicationController
  before_action :set_directory
  before_action :set_publicate_directory, only: %i(destroy)

  def index
    @publicate_directories = @directory.publicate_directories
  end

  def new
    @publicate_directory = @directory.publicate_directories.build
  end

  def create
    @publicate_directory = @directory.publicate_directories.build(publicate_directory_params)
    respond_to do |format|
      if @publicate_directory.save
        LinkMailer.send_mail(@publicate_directory.email, public_directory_url(@publicate_directory, access_token: @publicate_directory.access_token), current_user).deliver
        format.html { redirect_to [:my, @directory, :publicate_directories], notice: '公開しました' }
      else
        format.html { render 'new' }
      end
    end
  end

  def destroy
    @publicate_directory.destroy
    redirect_to [:my, @directory, :publicate_directories], notice: '公開を解除しました'
  end

  private

  def set_directory
    @directory = current_user.directories.find(params[:directory_id])
  end

  def set_publicate_directory
    @publicate_directory = @directory.publicate_directories.find(params[:id])
  end

  def publicate_directory_params
    return {} if params[:publicate_directory].blank?
    params.require(:publicate_directory).permit(:email)
  end
end
