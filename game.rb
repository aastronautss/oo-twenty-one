require_relative 'participant'
require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'game_interface'

require 'pry'

class TwentyOneGame
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def play
    deal_cards
    show_flop

    player_turn
    dealer_turn unless player.busted?

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
      prompt "#{player.name}'s turn:"
      choice = multiple_choice("What would you like to do?",
                               { 'h' => 'hit', 's' => 'stay' })

      if choice == 's'
        prompt "#{player.name} stays."
        break
      elsif player.busted?
        prompt "#{player.name} busts!"
        break
      else
        player.add_card(deck.draw_card)
        player.show_hand
        if player.busted?
          prompt "#{player.name} busts!"
          break
        end
      end
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
        dealer.add_card(deck.draw_card)
      end
    end
  end

  def show_result
    if tie?
      prompt "It's a tie!"
    elsif someone_busted?
      winner = player.busted? ? dealer.name : player.name
      display_winner(winner)
    else
      winner = (player.total > dealer.total ? player.name : dealer.name)
      display_winner(winner)
    end
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
end

TwentyOneGame.new.play
