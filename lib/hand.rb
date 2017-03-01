class Hand
  attr_reader :name, :stand, :cards

  def initialize(name:)
    @name = name
    @stand = false
    @cards = []
  end

  def pretty_cards
    names = @cards.map { |card| card.to_s }
    names.join(", ")
  end

  def summary
    score_message = "#{@name}'s Score: #{score} (#{pretty_cards})"
    if name == "Player"
      score_message.colorize(:blue)
    else
      score_message.colorize(:red)
    end
  end

  def score
    score = 0
    aces_count = 0
    @cards.each do |card|
      score += card.value
      if card.ace?
        aces_count += 1
      end
    end

    while score > 21 && aces_count > 0
      score -= 10
      aces_count -= 1 
    end
    score
  end

  def dealer_hit?(player_score:)
    score < 17 || player_score > score
  end

  def hit!(card:)
    @cards << card
  end

  def stand!
    @stand = true
  end

  def busts?
    score > 21
  end

  def blackjack?
    score == 21
  end

  def done?
    stand || busts? || blackjack?
  end
end