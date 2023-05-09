class HomeController < ApplicationController
  #before_action :authenticate_user! #, :except => [:index]
  def index
    @my_tasks=Card.where(username: current_user.username)
  end
end
