class FileitemsController < ApplicationController
  before_action :set_directory
  before_action :build_new_file, only: %i(new create)
  before_action :set_file, only: %i(show edit update destroy move copy share download)
  before_action :set_source_path, only: %i(update destroy move copy)

  after_action :save_event_log, only: %i(create update destroy move copy share)

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

  def download
    send_data(@file.bindata, filename: ERB::Util.url_encode(@file.name))
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

  def set_source_path
    @source_path = @file.pathname
  end

  def file_params
    params.require(:fileitem).permit(:name)
  end

  def save_event_log
    event                  = current_user.events.new
    event.directory_id     = @directory.id
    event.fileitem_id      = @file.id
    event.request          = request
    event.action           = params[:action]
    event.path             = @source_path.present? ? @source_path : @file.pathname
    event.destination_path = @file.pathname if %w(update move copy).include?(params[:action])
    event.save!
  end
end
