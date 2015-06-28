class Public::SubDirectoriesController < Public::ApplicationController
  before_action :set_root_publicate_directory, :set_directory, only: %i(show, download)
  before_action :set_file, only: %i(download)

  def show
    render 'public/directories/show'
  end

  def download
    send_data(@file.bindata, filename: ERB::Util.url_encode(@file.name))
  end

  private

  def set_root_publicate_directory
    @root_publicate_directory = PublicateDirectory.find_by!(access_token: session[:access_token])
  end

  def set_directory
    @directory = @root_publicate_directory.directory.subtree.find(params[:id])
  end

  def set_file
    @file = @directory.files.find(params[:file_id])
  end
end
