require "spec_helper"

RSpec.describe Hand do
  let(:deck) { Deck.new }
  let(:hand) { Hand.new(name: "Player") }
  let(:non_face_card) { Card.new(rank: 3, suit: '♥') }
  let(:face_card) { Card.new(rank: 'Q', suit: '♥') }
  let(:ace_card) { Card.new(rank: 'A', suit: '♠') }

  describe ".new" do
    it "initializes a hand with no cards" do
      expect(hand.cards).to eq([])
    end
  end

  it "has a name" do
    expect(hand.name).to eq("Player")
  end

  describe "#hit!" do
    it "adds a face card to the hand" do
      hand.hit!(card: face_card)
      expect(hand.cards).to eq([face_card])
    end

    it "adds a non face card to the hand" do
      hand.hit!(card: non_face_card)
      expect(hand.cards).to eq([non_face_card])
    end
  end

  describe "#score" do
    it "non-ace card hand score" do
      hand.hit!(card: non_face_card)
      expect(hand.score).to eq(3)
    end

    it "Ace is valued at 11 when the current score <= 10" do
      hand.hit!(card: non_face_card)
      hand.hit!(card: ace_card)
      expect(hand.score).to eq(14)
    end

    it "Ace is valued at 1 when the current score >= 11" do
      hand.hit!(card: face_card)
      hand.hit!(card: non_face_card)
      hand.hit!(card: ace_card)
      expect(hand.score).to eq(14)
    end
  end

  describe "#busts?" do
    it "returns true if score > 21" do
      hand.hit!(card: face_card)
      hand.hit!(card: face_card)
      hand.hit!(card: face_card)
      expect(hand.busts?).to eq(true)
    end
  end

  describe "#done?" do
    it "returns true if player stands" do
      hand.stand!
      expect(hand.done?).to eq(true)
    end

    it "returns true if player has a blackjack" do
      hand.hit!(card: face_card)
      hand.hit!(card: face_card)
      hand.hit!(card: ace_card)
      expect(hand.done?).to eq(true)
    end

    it "returns true if player busts" do
      hand.hit!(card: face_card)
      hand.hit!(card: face_card)
      hand.hit!(card: face_card)
      hand.busts?
      expect(hand.done?).to eq(true)
    end
  end

end