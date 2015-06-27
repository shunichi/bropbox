class Public::ApplicationController < ActionController::Base
  skip_before_action :authenticate_user!

  layout 'layouts/public'
end
