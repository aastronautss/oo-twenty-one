require_relative 'participant'
require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'game_interface'

class TwentyOneGame
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def play
    display_welcome_message
    loop do
      play_round
      break unless play_again?
    end
    display_goodbye_message
  end

  def play_round
    deal_cards
    show_flop

    player_turn
    dealer_turn unless player.busted? || player.blackjack?

    show_result
  end

  def deal_cards
    2.times do
      player.add_card(deck.draw_card)
      dealer.add_card(deck.draw_card)
    end
  end

  def show_flop
    player.show_flop
    dealer.show_flop
  end

  def player_turn
    loop do
      if player.busted?
        prompt "#{player.name} busts!"
        break
      end

      choice = player_prompt
      hit(player) if choice == 'h'
      player.show_hand
    end
  end

  def dealer_turn
    prompt "#{dealer.name}'s turn:"

    loop do
      dealer.show_hand
      if dealer.busted?
        prompt "#{dealer.name} busts!"
        break
      elsif dealer.total >= 17
        prompt "#{dealer.name} stays!"
        break
      else
        prompt "#{dealer.name} hits!"
        hit(dealer)
      end
    end
  end

  def player_prompt
    prompt "#{player.name}'s turn:"
    multiple_choice("What would you like to do?",
                    'h' => 'hit', 's' => 'stay')
  end

  def show_result
    if tie?
      winner = "Nobody"
    elsif someone_busted?
      winner = player.busted? ? dealer.name : player.name
    else
      winner = (player.total > dealer.total ? player.name : dealer.name)
    end

    display_winner winner
  end

  def tie?
    player.total == dealer.total
  end

  def someone_busted?
    player.busted? || dealer.busted?
  end

  def display_winner(winner)
    prompt "#{winner} wins!"
  end

  def hit(participant)
    participant.add_card(deck.draw_card)
  end

  def play_again?
    bool_input "Play again?"
  end

  def display_welcome_message
    prompt "Welcome to Twenty-One!"
  end

  def display_goodbye_message
    prompt "Thanks for playing Twenty-One! Goodbye!"
  end
end

TwentyOneGame.new.play
