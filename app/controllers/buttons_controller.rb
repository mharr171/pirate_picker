class ButtonsController < ApplicationController

  def checkbomb
    @room = Room.find(params[:room_id])
    @button = Button.find(params[:button_id])

    if @button.bomb == true
      flash[:alert] = "Boom."
      @button.update_attribute(:clicked, true)
      @room.update_attributes(game_end:true, game_start:true)
    else
      flash[:notice] = "Safe."
      @button.update_attribute(:clicked, true)
    end

    redirect_to room_path(@room)
  end
end
