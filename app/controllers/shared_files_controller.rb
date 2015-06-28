class SharedFilesController < ApplicationController
  before_action :set_file, only: %i(show)

  def index
    @shared_files = current_user.shared_files
  end

  def show
    send_data(@file.bindata, filename: ERB::Util.url_encode(@file.name))
  end

  private

  def set_file
    if params[:shared_directory_id]
      shared_root_directory = SharedDirectory.find(params[:shared_directory_id])
      shared_directory = shared_root_directory.directory.subtree.find(params[:shared_sub_directory_id])
      @file = shared_directory.files.find(params[:id])
    else
      @file = current_user.shared_files.find(params[:id]).fileitem
    end
  end
end
