class Deck
  attr_reader :cards
  SUITS = ['♥', '♣', '♦', '♠']
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

  def initialize
    @cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        @cards << Card.new(rank: rank, suit: suit)
      end
    end
    @cards.shuffle!
  end

  def deal!
    @cards.pop
  end

end