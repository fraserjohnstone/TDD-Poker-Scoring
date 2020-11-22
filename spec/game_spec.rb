require_relative "../lib/game"
require_relative "../lib/input_parser"

describe Game do
  subject(:game) { Game.new(input) }

  let(:input) { "Black: 2H 3D 5S 9C KD White: 2C 3H 4S 8C AH" }
  let(:parsed_input) {
    {
        black: %w[2H 3D 5S 9C KD],
        white: %w[2C 3H 4S 8C AH]
    }
  }
  # let(:expected_output) { "White wins - high card: Ace" }

  it "will parse the input" do
    expect_any_instance_of(InputParser).to receive(:parse).and_return(parsed_input)
    game
  end

  it "will create the cards", :aggregate_failures do
    %w[2H 3D 5S 9C KD 2C 3H 4S 8C AH].each do |identifier|
      expect(Card).to receive(:new).with(identifier)
    end
    game
  end

  context "when the hand classifications are not the same" do
    let(:input) { "Black: 2H 2D 2S 2C KD White: 2C 3H 4S 8C AH" }

    it "will tell us that the hand with the most classification points is the winner" do
      expect(game.result).to eq "Black wins - Four of a Kind"
    end

    context "when black wins with a straight flush" do
      let(:input) { "Black: 2D 3D 4D 5D 6D White: 2C 3H 4S 8C AH" }

      it "will tell us that black wins with a straight flush" do
        expect(game.result).to eq "Black wins - Straight Flush"
      end
    end

    context "when white wins" do
      let(:input) { "Black: 2H 2D 3S 3C KD White: 2C 3C 4C 8C AC" }

      it "will tell us that white has won with the correct hand" do
        expect(game.result).to eq "White wins - Flush"
      end

      context "when white wins with a straight flush" do
        let(:input) { "Black: 2H 2H 4C 5D 6D White: 2C 3C 4C 5C 6C" }

        it "will tell us that white wins with a straight flush" do
          expect(game.result).to eq "White wins - Straight Flush"
        end
      end
    end
  end

  context "when the hand classifications are the same" do
    context "when the classification is High Card" do
      let(:input) { "Black: 2H 4D 6S 5C KD White: 2C 3C 4C 8D AC" }

      it "will tell us that white wins with a high card Ace" do
        expect(game.result).to eq "White wins - High card: Ace"
      end

      context "the black hand has a higher high card" do
        let(:input) { "Black: 2H 4D 6S 5C KD White: 2C 3C 4C 8D JC" }

        it "will tell us that white wins with a high card King" do
          expect(game.result).to eq "Black wins - High card: King"
        end
      end
    end
  end
end
