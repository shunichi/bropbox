class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    redirect_to [current_user.directories.first.root] if user_signed_in?
  end
end
