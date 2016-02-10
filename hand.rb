class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def <<(card)
    @cards << card
  end

  def first
    @cards.first
  end

  def total
    aces = @cards.select(&:ace?) # First take out aces
    hand_minus_aces = @cards - aces

    sum = hand_minus_aces.inject(0) do |running_total, card|
      running_total + evaluate_non_ace_card(card)
    end

    aces.each do |_| # Add aces
      sum += one_or_eleven sum
    end

    sum
  end

  # If the card is above 11 (i.e. a face card), returns 10.
  def evaluate_non_ace_card(card)
    card.face_card? ? 10 : card.value
  end

  # Used to evaluate an Ace card based on the given sum
  # (Avoids busting if possible)
  def one_or_eleven(sum)
    sum + 11 > 21 ? 1 : 11
  end

  def bust?
    total > 21
  end

  def to_s
    @cards.map(&:to_s).join("\n")
  end
end
