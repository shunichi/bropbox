class EventsController < ApplicationController
  def index
    @events = current_user.events.page(params[:page]).order(created_at: :desc)
  end
end
