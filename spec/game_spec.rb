require "spec_helper"

RSpec.describe Game do
  let(:player) { Hand.new(name: "Player") }
  let(:dealer) { Hand.new(name: "Dealer") }
  let(:deck) { Deck.new }
  let(:game) { Game.new(player: player, dealer: dealer, deck: deck) }

  describe ".new" do
    it "initializes a new game with a dealer" do
      expect(game.dealer).to be(dealer)
    end

    it "initializes a new game with a player" do
      expect(game.player).to be(player)
    end

    it "initializes a new game with a deck" do
      expect(game.deck).to be(deck)
    end
  end

  describe "#next_card" do
    it "retrieves one card from the deck" do
      expect(game.next_card).to be_an_instance_of(Card)
    end
  end

  describe "#opponents" do
    it "should return an array of the player and dealer in that order" do
      expect(game.opponents).to eq([player, dealer])
    end
  end

  describe "#start" do
    it "should give the player and the dealer 2 uniq cards" do
      game.start
      expect(dealer.cards.count).to eq(2)
      expect(player.cards.count).to eq(2)
    end

    it "should remove 4 cards in total from the deck" do
      game.start
      expect(deck.cards.count).to eq(48)
    end
  end

end