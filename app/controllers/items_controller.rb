class ItemsController < ApplicationController
  def index
  end

  def search
    @directories = current_user.directories.match(params[:q])
    @files = current_user.files.match(params[:q])
    render 'index'
  end
end
