require_relative "../lib/hand_classifier"
require_relative "../lib/hand"
require_relative "../lib/card"

describe HandClassifier do
  describe "#classify" do
    subject(:classify) { described_class.new(hand).classify }

    let(:hand) do
      Hand.new(cards)
    end
    let(:cards) do
      [
          Card.new("2D"),
          Card.new("5C"),
          Card.new("7H"),
          Card.new("AD"),
          Card.new("9S")
      ]
    end

    context "when there is only a high card" do
      it { is_expected.to eq "High Card" }
    end

    context "when there is a pair" do
      let(:cards) do
        [
            Card.new("2D"),
            Card.new("2C"),
            Card.new("7H"),
            Card.new("AD"),
            Card.new("9S")
        ]
      end

      it { is_expected.to eq "Pair" }
    end

    context "when there are two pairs" do
      let(:cards) do
        [
            Card.new("2D"),
            Card.new("2C"),
            Card.new("3H"),
            Card.new("3D"),
            Card.new("9S")
        ]
      end

      it { is_expected.to eq "Two Pairs" }
    end

    context "when there is three of a kind" do
      let(:cards) do
        [
            Card.new("2D"),
            Card.new("2C"),
            Card.new("2H"),
            Card.new("3D"),
            Card.new("9S")
        ]
      end

      it { is_expected.to eq "Three of a Kind" }
    end

    context "when there is a straight" do
      let(:cards) do
        [
            Card.new("2D"),
            Card.new("3C"),
            Card.new("4H"),
            Card.new("5D"),
            Card.new("6S")
        ]
      end

      it { is_expected.to eq "Straight" }
    end

    context "when there is a flush" do
      let(:cards) do
        [
            Card.new("2D"),
            Card.new("3D"),
            Card.new("2D"),
            Card.new("5D"),
            Card.new("5D")
        ]
      end

      it { is_expected.to eq "Flush" }
    end

    context "when there is four of a kind" do
      let(:cards) do
        [
            Card.new("2D"),
            Card.new("2C"),
            Card.new("2S"),
            Card.new("2D"),
            Card.new("6D")
        ]
      end

      it { is_expected.to eq "Four of a Kind" }
    end

    context "when there is a straight flush" do
      let(:cards) do
        [
            Card.new("2D"),
            Card.new("3D"),
            Card.new("4D"),
            Card.new("5D"),
            Card.new("6D")
        ]
      end

      it { is_expected.to eq "Straight Flush" }
    end
  end
end
