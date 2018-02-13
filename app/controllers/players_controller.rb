class PlayersController < ApplicationController

  def create
    @room = Room.find(params[:room_id])
    @player = Player.new
    @player.user = current_user
    @player.room = @room

    if @player.save
      flash[:notice] = "#{@player.user.username} added."
      redirect_to room_path(@room.id)
    else
      flash[:alert] = "There was an error, player not added."
      redirect_to room_path(@room.id)
    end
  end

  def destroy
    @room = Room.find(params[:room_id])
    @player = Player.find(params[current_user])

    if @player.destroy
      flash[:notice] = "Player removed."
      redirect_to room_path(@room.id)
    else
      flash[:alert] = "There was an error, player not removed."
      redirect_to room_path(@room.id)
    end
  end
end
