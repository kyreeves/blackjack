class Hand
  attr_reader :name, :stand, :cards

  def initialize(name:)
    @name = name
    @stand = false
    @cards = []
  end

  def to_s
    name
  end

  def name_cards
    name_cards = ""
    @cards.each do |card|
      name_cards << card.to_s
    end
    name_cards
  end

  def summary
    score_message = "#{@name}'s Score: #{score} (#{name_cards})"
    if name == "Player"
      score_message.colorize(:blue)
    else
      score_message.colorize(:red)
    end
  end

  def score
    score = 0
    @cards.each do |card|
      score += card.value(score: score)
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

  def twenty_one?
    score == 21
  end

  def done?
    stand || busts? || twenty_one?
  end
end