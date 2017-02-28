require "spec_helper"

RSpec.describe Card do
  let(:non_face_card) { Card.new(rank: 9, suit: '♠') }
  let(:face_card) { Card.new(rank: 'Q', suit: '♦') }
  let(:ace) { Card.new(rank: 'A', suit: '♦') }

  it 'has a rank' do
    expect(non_face_card.rank).to eq(9)
  end

  it 'has a suit' do
    expect(non_face_card.suit).to eq('♠')
  end

  describe "#value" do
    it 'returns the numerical value of a non face card' do
      expect(non_face_card.value(score: 10)).to eq(9)
    end

    it 'returns 10 for a face card' do
      expect(face_card.value(score: 1)).to eq(10)
    end

    it 'returns 11 for an ace card when score is less than or equal to 10' do
      expect(ace.value(score: 3)).to eq(11)
    end

    it 'returns 1 for an ace card when score is greater than 10' do
      expect(ace.value(score: 14)).to eq(1)
    end
  end

  describe "#to_s" do
    it "prints out a face card's rank and suit in a nice format" do
      expect(face_card.to_s).to eq("Q-♦")
    end

    it "prints out a non-face card's rank and suit in a nice format" do
      expect(non_face_card.to_s).to eq("9-♠")
    end
  end

end