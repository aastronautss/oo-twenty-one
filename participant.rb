require_relative 'hand'

class Participant
  attr_accessor :name, :hand

  def initialize
    set_name
    @hand = Hand.new
  end

  def total
    @hand.total
  end

  def busted?
    @hand.bust?
  end

  def add_card(card)
    @hand << card
  end

  def show_hand
    prompt "#{name}'s hand:"
    puts "#{hand}"
  end
end
