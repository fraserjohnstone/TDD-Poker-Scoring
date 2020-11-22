require_relative "../lib/hand"
require_relative "../lib/hand_classifier"
require_relative "../lib/card"

describe Hand do
  let(:hand) { described_class.new(cards) }

  let(:cards) do
    [
        Card.new("2D"),
        Card.new("5C"),
        Card.new("7H"),
        Card.new("AD"),
        Card.new("9S")
    ]
  end

  describe "#classification" do
    subject(:classification) { hand.classification }

    it { is_expected.to eq "High Card" }

    context "when it is a four of a kind" do
      let(:cards) do
        [
            Card.new("5D"),
            Card.new("5C"),
            Card.new("5H"),
            Card.new("5D"),
            Card.new("9S")
        ]
      end

      it { is_expected.to eq "Four of a Kind" }
    end
  end

  describe "#card_values" do
    subject(:card_values) { hand.card_values }

    it { is_expected.to eq [2, 5, 7, 10, 9] }
  end

  describe "#sorted_card_values" do
    subject(:sorted_card_values) { hand.sorted_card_values }

    it { is_expected.to eq [2, 5, 7, 9, 10] }
  end

  describe "#card_suits" do
    subject(:card_suits) { hand.card_suits }

    it { is_expected.to eq %w[Diamonds Clubs Hearts Diamonds Spades] }
  end

  describe "#classification_points" do
    subject(:classification_points) { hand.classification_points }

    it { is_expected.to eq 1 }

    context "when the hand classification is Pair" do
      let(:cards) do
        [
            Card.new("5D"),
            Card.new("5C"),
            Card.new("3H"),
            Card.new("2D"),
            Card.new("9S")
        ]
      end

      it { is_expected.to eq 2 }
    end

    context "when the hand classification is High Card" do
      let(:cards) do
        [
            Card.new("5D"),
            Card.new("4C"),
            Card.new("3H"),
            Card.new("2D"),
            Card.new("9S")
        ]
      end

      it { is_expected.to eq 1 }
    end

    context "when the hand classification is Two pairs" do
      let(:cards) do
        [
            Card.new("5D"),
            Card.new("5C"),
            Card.new("3H"),
            Card.new("3D"),
            Card.new("9S")
        ]
      end

      it { is_expected.to eq 3 }
    end

    context "when the hand classification is Three of a Kind" do
      let(:cards) do
        [
            Card.new("5D"),
            Card.new("5C"),
            Card.new("5H"),
            Card.new("3D"),
            Card.new("9S")
        ]
      end

      it { is_expected.to eq 4 }
    end

    context "when the hand classification is Straight" do
      let(:cards) do
        [
            Card.new("2D"),
            Card.new("3C"),
            Card.new("4H"),
            Card.new("5D"),
            Card.new("6S")
        ]
      end

      it { is_expected.to eq 5 }
    end

    context "when the hand classification is Flush" do
      let(:cards) do
        [
            Card.new("2D"),
            Card.new("3D"),
            Card.new("4D"),
            Card.new("4D"),
            Card.new("6D")
        ]
      end

      it { is_expected.to eq 6 }
    end

    context "when the hand classification is Full House" do
      let(:cards) do
        [
            Card.new("2D"),
            Card.new("2C"),
            Card.new("2D"),
            Card.new("3D"),
            Card.new("3D")
        ]
      end

      it { is_expected.to eq 7 }
    end

    context "when it is a four of a kind" do
      let(:cards) do
        [
            Card.new("5D"),
            Card.new("5C"),
            Card.new("5H"),
            Card.new("5D"),
            Card.new("9S")
        ]
      end

      it { is_expected.to eq 8 }
    end

    context "when the hand classification is Straight Flush" do
      let(:cards) do
        [
            Card.new("2D"),
            Card.new("3D"),
            Card.new("4D"),
            Card.new("5D"),
            Card.new("6D")
        ]
      end

      it { is_expected.to eq 9 }
    end
  end

  describe "#high_card_info" do
    subject(:high_card_info) { hand.high_card_info }

    let(:expected_response) { ["Ace", 10] }

    it { is_expected.to be_an Array }

    it "will be an array of size 2" do
      expect(high_card_info.size).to eq 2
    end

    it "will return an array with the first element a string" do
      expect(high_card_info.first).to be_a String
    end

    it "will return an array with the first element an integer" do
      expect(high_card_info.last).to be_an Integer
    end

    it "will return Ace for the first element in the array" do
      expect(high_card_info.first).to eq "Ace"
    end

    it "will return 10 for the second element in the array" do
      expect(high_card_info.last).to eq 10
    end

    context "when the high card is a four" do
      let(:cards) do
        [
            Card.new("2D"),
            Card.new("3D"),
            Card.new("4D"),
            Card.new("2D"),
            Card.new("2D")
        ]
      end

      it "will return 4 for the first element in the array" do
        expect(high_card_info.first).to eq "4"
      end

      it "will return 10 for the second element in the array" do
        expect(high_card_info.last).to eq 4
      end
    end

    context "when the high card is a nine" do
      let(:cards) do
        [
            Card.new("2D"),
            Card.new("3D"),
            Card.new("9D"),
            Card.new("9D"),
            Card.new("2D")
        ]
      end

      it "will return 9 for the first element in the array" do
        expect(high_card_info.first).to eq "9"
      end

      it "will return 9 for the second element in the array" do
        expect(high_card_info.last).to eq 9
      end
    end
  end
end
