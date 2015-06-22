class DirectoriesController < ApplicationController
  before_action :set_directory, only: %i(show edit update destroy update move copy share)
  before_action :set_source_path, only: %i(update destroy move copy)
  before_action :set_parent_directory, only: %i(new create)

  after_action :save_event_log, only: %i(create update destroy move copy share)

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
    respond_to do |format|
      if @directory.update(directory_params)
        format.html { redirect_to [@directory.parent], notice: 'フォルダ名を変更しました' }
      else
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    @directory.destroy
    redirect_to [@directory.parent], notice: "#{@directory.name} を削除しました"
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

  def set_source_path
    @source_path = @directory.pathname
  end

  def set_parent_directory
    @parent_directory = current_user.directories.find(params[:parent_id])
  end

  def directory_params
    params.require(:directory).permit(:name)
  end

  def save_event_log
    event                  = current_user.events.new
    event.directory_id     = @directory.id
    event.request          = request
    event.action           = params[:action]
    event.path             = @source_path.present? ? @source_path : @directory.pathname
    event.destination_path = @directory.pathname if %w(update move copy).include?(params[:action])
    event.save!
  end
end
