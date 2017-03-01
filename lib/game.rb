class Game
  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Hand.new(name: "Player")
    @dealer = Hand.new(name: "Dealer")
  end

  def opponents
    [player, dealer]
  end

  def summarize
    opponents.each { |opp| puts opp.summary }
  end

  def start
    opponents.each do |opp|
      2.times { opp.hit!(card: deck.deal!) }
    end
  end

  def initial_blackjack_check
    if player.blackjack? || dealer.blackjack?
      show_game_result
      summarize
      exit
    end
  end

  def player_move
    while player.done? == false
      puts "Players Turn: Hit or Stand (h/s)?: ".colorize(:green)
      player_input = gets.chomp.downcase
      evaluate_input(player_input: player_input)
    end
  end

  def evaluate_input(player_input:)
    case player_input
    when "s"
      player.stand!
      puts "#{player.name} stands.".colorize(:green)
    when "h"
      player.hit!(card: deck.deal!)
      puts player.summary
    else
      puts "Invalid Response! Enter (h) to HIT or (s) to STAND.".colorize(:green)
    end
  end

  def player_bust_check
    if player.busts?
      puts "#{player.name} BUST! #{dealer.name} WINS".colorize(:light_cyan)
      opponents.each { |opp| puts opp.summary }
      exit
    end
  end

  def dealer_move
    puts "Dealer's Turn: ".colorize(:green)
    while dealer.dealer_hit?(player_score: player.score)
      card = deck.deal!
      dealer.hit!(card: card)
    end
  end

  def dealer_bust_check
    if dealer.score > 21
      puts "#{dealer.name} BUST! #{player.name} WINS!".colorize(:light_cyan)
      summarize
      exit
    end
  end

  def evaluate_winner
    opponents.max_by(&:score)
  end

  def show_game_result
    case evaluate_winner
    when player
      puts "Good Job! #{player.name} Wins!".colorize(:light_cyan)
    when dealer
      puts "Oh no! #{dealer.name} Wins!".colorize(:light_cyan)
    else
      puts "It's a push!".colorize(:light_cyan)
    end
  end

end