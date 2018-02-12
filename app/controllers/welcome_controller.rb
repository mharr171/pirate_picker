class WelcomeController < ApplicationController
  def index
    @rooms = Room.all
    @room = Room.new
  end
end
