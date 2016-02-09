require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        @cards << Card.new(value, suit)
      end
    end

    shuffle!
  end

  def shuffle!
    cards.shuffle!
  end

  def draw_card
    cards.pop
  end
end
