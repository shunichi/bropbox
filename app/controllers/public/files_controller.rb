class Public::FilesController < Public::ApplicationController
  before_action :set_publicate_file, :set_file, :check_access_token, only: %i(show)

  def show
    send_data(@file.bindata, filename: ERB::Util.url_encode(@file.name))
  end

  private

  def set_publicate_file
    @publicate_file = PublicateFile.find(params[:id])
  end

  def set_file
    @file = @publicate_file.fileitem
  end

  def check_access_token
    return head(:bad_request) if @publicate_file.access_token != params[:access_token]
  end
end
