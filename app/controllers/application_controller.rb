class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  helper_method :publicate_directory_full_url

  def publicate_directory_full_url(publicate_directory)
    "#{polymorphic_url([publicate_directory])}?access_token=#{publicate_directory.access_token}"
  end
end
