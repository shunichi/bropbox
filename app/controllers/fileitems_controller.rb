class FileitemsController < ApplicationController
  before_action :set_directory, only: %i(show new create edit update destroy)
  before_action :set_destination_directory, only: %i(move copy)
  before_action :build_new_file, only: %i(new create)
  before_action :set_file, only: %i(show edit update destroy move copy share)
  before_action :set_source_path, only: %i(update destroy move copy)
  before_action :set_destination_path, only: %i(update destroy move copy)

  after_action :save_event_log, only: %i(create update destroy move copy share)

  def show
    send_data(@file.bindata, filename: ERB::Util.url_encode(@file.name))
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
        @destination_path = @file.pathname
        format.html { redirect_to [@file.directory], notice: 'ファイル名を変更しました' }
      else
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    @file.destroy
    redirect_to @file.directory, notice: 'ファイルを削除しました'
  end

  def move
    @file.move(@destination_directory)
    respond_to do |format|
      format.json
    end
  end

  def copy
    @file.copy(@destination_directory)
    respond_to do |format|
      format.json
    end
  end

  def share
  end

  private

  def set_directory
    @directory = current_user.directories.find(params[:directory_id])
  end

  def set_destination_directory
    @destination_directory = current_user.directories.find(params[:destination_id])
  end

  def build_new_file
    @file = @directory.files.build
  end

  def set_file
    @file = current_user.files.find(params[:id])
  end

  def set_source_path
    @source_path = @file.pathname
  end

  def set_destination_path
    @destination_path = "#{@destination_directory.pathname}/#{@file.name}" if @destination_directory.present?
    @destination_path ||= @file.pathname
  end

  def file_params
    params.require(:fileitem).permit(:name)
  end

  def save_event_log
    event                  = current_user.events.new
    event.directory_id     = @file.directory.id
    event.fileitem_id      = @file.id
    event.request          = request
    event.action           = params[:action]
    # event.path             = @source_path.presence || @file.pathname
    # または
    # event.path             = @source_path || @file.pathname
    # でもいい気がする("" や [] になることはないので)
    event.path             = @source_path.present? ? @source_path : @file.pathname
    event.destination_path = @destination_path if @destination_path.present?
    event.save!
  end
end
