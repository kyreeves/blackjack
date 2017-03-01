class Card
  attr_reader :rank, :suit

  def initialize(rank:, suit:)
    @rank = rank
    @suit = suit
  end

  def value
    if ['J', 'Q', 'K'].include?(rank)
      10
    elsif ace?
      11
    else
      rank
    end
  end

  def ace?
    rank == 'A'
  end

  def to_s
    "#{rank}-#{suit}"
  end
end