require 'faker'
class RoomsController < ApplicationController
  def show
    if params[:room_id]
      @room = Room.find(params[:room_id])
    else
      @room = Room.find(params[:id])
    end
    @player = Player.new
  end

  def create
    @room = Room.new
    @room.name = generated_name
    @room.game_start = false
    @room.game_end = false
    @room.user = current_user

    if @room.save
      flash[:notice] = "Room #{@room.name} created."
      @room.players.create!(
        user: current_user,
        room: @room
      )
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

  def startgame
    @room = Room.find(params[:room_id])
    @room.update_attributes(game_start:true,game_end:false)

    if @room.buttons.empty?

      r = rand(1..24)
      count = 0
      24.times do
        count += 1
        b = Button.new(bomb:false,clicked:false,color:rand(1..4))
        b.room = @room
        b.bomb = true if r == count
        b.save!
      end

    else

      r = rand(1..24)
      count = 0
      @room.buttons.each do |button|
        count += 1
        if r == count
          button.update_attributes!(bomb:true,clicked:false,color:rand(1..4))
        else
          button.update_attributes!(bomb:false,clicked:false,color:rand(1..4))
        end
      end

    end

    @room.save
    redirect_to room_path(@room)
  end

  def resetgame
    @room = Room.find(params[:room_id])
    @room.update_attributes(game_start:false,game_end:false)

    if @room.buttons.empty?

      r = rand(1..24)
      count = 0
      24.times do
        count += 1
        b = Button.new(bomb:false,clicked:false,color:rand(1..4))
        b.room = @room
        b.bomb = true if r == count
        b.save!
      end

    else

      r = rand(1..24)
      count = 0
      @room.buttons.each do |button|
        count += 1
        if r == count
          button.update_attributes!(bomb:true,clicked:false,color:rand(1..4))
        else
          button.update_attributes!(bomb:false,clicked:false,color:rand(1..4))
        end
      end

    end

    @room.save
    redirect_to room_path(@room)
  end

  def leavegame
    @room = Room.find(params[:room_id])
    @player = Player.all.where(user: current_user).first

    if @player.destroy
      flash[:notice] = "Player removed."
      redirect_to room_path(@room.id)
    else
      flash[:alert] = "There was an error, player not removed."
      redirect_to room_path(@room.id)
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
