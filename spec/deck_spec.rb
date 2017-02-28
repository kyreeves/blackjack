require "spec_helper"

RSpec.describe Deck do
  let(:deck) { Deck.new }

  it 'has a reader for cards' do
    expect(deck.cards).to be_an(Array)
  end

  describe ".new" do
    it "generates 52 cards for the deck" do
      expect(deck.cards.count).to eq(52)
    end

    it "generates 52 unique cards for the deck" do
      mapped_cards = deck.cards.map!{|card| "#{card.rank} of #{card.suit}"}
      expect(deck.cards.uniq.count).to eq(52)
    end

    it "makes sure the 52 cards are not in order" do
      expect(deck.cards[0..3].map { |card| card.rank }).to_not eq([2, 2, 2, 2])
    end
  end

  describe "#draw!" do
    it "returns the top card off the deck" do
      top_card = deck.cards[-1]
      expect(deck.deal!).to eq(top_card)
    end
  end
end