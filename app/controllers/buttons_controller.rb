class ButtonsController < ApplicationController

  def checkbomb
    @room = Room.find(params[:room_id])
    @button = Button.find(params[:button_id])

    if @button.bomb == true
      flash[:alert] = "Boom."
      @button.update_attributes(clicked: true, color: 5)
      @room.update_attributes(game_end:true, game_start:true, last_loser: current_user.username)
    else
      flash[:notice] = "Safe."
      @button.update_attribute(:clicked, true)
    end

    change_turn

    redirect_to room_path(@room)
  end

  private

  def change_turn
    players = []
    turnlist = @room.turnlist



    # easy.deliver("5551234567", "verizon", "Hey!")
    players << @room.turnlist.first if turnlist.first != nil
    players << @room.turnlist.second if turnlist.second != nil
    players << @room.turnlist.third if turnlist.third != nil
    players << @room.turnlist.fourth if turnlist.fourth != nil

    case players.count
    when 1
    when 2
      if @room.turn_id == turnlist.second
        @room.update_attribute(:turn_id, players[0])
      elsif @room.turn_id == turnlist.first
        @room.update_attribute(:turn_id, players[1])
      else
        flash[:alert] = "There was an error with the turns."
      end
    when 3
      if @room.turn_id == turnlist.third
        @room.update_attribute(:turn_id, players[0])
      elsif @room.turn_id == turnlist.first
        @room.update_attribute(:turn_id, players[1])
      elsif @room.turn_id == turnlist.second
        @room.update_attribute(:turn_id, players[2])
        flash[:alert] = "There was an error with the turns."
      end
    when 4
      if @room.turn_id == turnlist.fourth
        @room.update_attribute(:turn_id, players[0])
      elsif @room.turn_id == turnlist.first
        @room.update_attribute(:turn_id, players[1])
      elsif @room.turn_id == turnlist.second
        @room.update_attribute(:turn_id, players[2])
      elsif @room.turn_id == turnlist.third
        @room.update_attribute(:turn_id, players[3])
      else
        flash[:alert] = "There was an error with the turns."
      end
    end
    users_turn = User.find(@room.turn_id)
    if users_turn.phone_option
      send_text(@room, users_turn)
    end
  end

  def send_text room, user
    easy = SMSEasy::Client.new
    num = user.phone_number
    car = user.carrier_name
    @msg = "Your turn on Pirate Picker, Room \"#{room.name}\""

    easy.deliver(num, car, @msg, from:'noreply@pirate-picker.herokuapp.com')
  end

end
