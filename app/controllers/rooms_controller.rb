require 'faker'
class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.new
    @room.name = generated_name
    @room.user = current_user

    if @room.save
      flash[:notice] = "Room #{@room.name} created."
      redirect_to room_path(@room)
    else
      flash[:alert] = "There was an error, room not created."
      redirect_to root_path
    end
  end

  def destroy
    @room = Room.find(params[:id])

    if @room.destroy
      flash[:notice] = "Room deleted."
      redirect_to root_path
    else
      flash[:alert] = "There was an error, room was not deleted."
      redirect_to room_path(@room)
    end
  end

  private

  def room_params
    params.require(:room).permit()
  end

  def generated_name
    Faker::Pokemon.name + "-" + Faker::Pokemon.name
  end
end
