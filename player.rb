require_relative 'game_interface'

class Player < Participant
  def set_name
    @name = text_input("What's your name?")
  end

  def show_flop
    prompt "#{name}'s hand:"
    puts @hand
  end
end
