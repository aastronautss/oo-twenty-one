class Card
  CARD_NAMES = { 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6",
                 7 => "7", 8 => "8", 9 => "9", 10 => "10",
                 11 => "Jack", 12 => "Queen", 13 => "King", 14 => "Ace" }
  SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  VALUES = (2..14).to_a
  FACE_CARD_VALUES = (11..13)

  attr_accessor :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def face
    CARD_NAMES[value]
  end

  def to_s
    "#{face} of #{@suit}"
  end

  def ace?
    value == 14
  end

  def face_card?
    FACE_CARD_VALUES === value
  end
end
