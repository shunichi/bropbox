class SharedDirectoriesController < ApplicationController
  def index
    @shared_directories = current_user.shared_directories
  end
end
