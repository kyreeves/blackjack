class Game
  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Hand.new(name: "Player")
    @dealer = Hand.new(name: "Dealer")
  end

  def next_card
    deck.deal!
  end

  def opponents
    [player, dealer]
  end

  def summarize
    opponents.each { |opp| puts opp.summary }
  end

  def start
    opponents.each do |opp|
      2.times { opp.hit!(card: next_card) }
    end
  end

  def exit_game
    summarize
    exit
  end

  def blackjack_check
    if opponents.any? { |opp| opp.blackjack? }
      show_game_result
      exit_game
    end
  end

  def player_move
    while player.done? == false
      puts "Players Turn: Hit or Stand (h/s)?: "
      response = gets.chomp.downcase
      evaluate_player_input(player_input: response)
    end
  end

  def evaluate_player_input(player_input:)
    case player_input
    when "s"
      player.stand!
      puts "#{player.name} stands."
    when "h"
      player.hit!(card: next_card)
      puts player.summary
    else
      puts "ERROR: Invalid Response! Enter (h) to HIT or (s) to STAND."
    end
  end

  def dealer_move
    puts "Dealer's Turn: "
    while dealer.dealer_hit?
      dealer.hit!(card: next_card)
    end
  end

  def bust_check
    if player.busts?
      bust_event(buster: player, winner: dealer)
    elsif dealer.busts?
      bust_event(buster: dealer, winner: player)
    end
  end

  def bust_event(buster:, winner:)
    puts "#{buster.name} BUSTS! #{winner.name} WINS!"
    exit_game
  end

  def evaluate_winner
    if player.score > dealer.score
      player
    elsif player.score < dealer.score
      dealer
    end
  end

  def show_game_result
    case evaluate_winner
    when player
      puts "Good Job! #{player.name} Wins!"
    when dealer
      puts "Oh no! #{dealer.name} Wins!"
    else
      puts "It's a push!"
    end
  end

end