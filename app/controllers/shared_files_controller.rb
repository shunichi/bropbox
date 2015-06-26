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
    @file = current_user.shared_files.find(params[:id]).fileitem
  end
end
