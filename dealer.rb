class Dealer < Participant
  ROBOTS = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']

  def set_name
    @name = ROBOTS.sample
  end

  def show_flop
    prompt "#{name}'s hand:"
    puts @hand.first
  end
end
