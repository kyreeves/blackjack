class Card
  attr_reader :rank, :suit

  def initialize(rank:, suit:)
    @rank = rank
    @suit = suit
  end

  def value(score:)
    if ['J', 'Q', 'K'].include?(rank)
      10
    elsif rank == 'A'
      score <= 10 ? 11 : 1
    else
      rank
    end
  end

  def to_s
    "#{rank}-#{suit}"
  end
end