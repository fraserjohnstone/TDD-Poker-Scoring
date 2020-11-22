require_relative '../lib/card'

describe Card do
  let(:card) { described_class.new(identifier) }

  let(:identifier) { "2H" }

  describe "#suit" do
    subject(:suit) { card.suit }

    it { is_expected.to eq "Hearts" }

    context "when the card is a Diamond" do
      let(:identifier) { "2D" }

      it { is_expected.to eq "Diamonds" }
    end

    context "when the card is a Club" do
      let(:identifier) { "2C" }

      it { is_expected.to eq "Clubs" }
    end

    context "when the card is a Spade" do
      let(:identifier) { "2S" }

      it { is_expected.to eq "Spades" }
    end
  end

  describe "#rank" do
    subject(:rank) { card.rank }

    it { is_expected.to eq "2" }

    context "when the card is a 4" do
      let(:identifier) { "4D" }

      it { is_expected.to eq "4" }
    end

    context "when the card is a 7" do
      let(:identifier) { "7C" }

      it { is_expected.to eq "7" }
    end

    context "when the card is a King" do
      let(:identifier) { "KC" }

      it { is_expected.to eq "King" }
    end

    context "when the card is a Ace" do
      let(:identifier) { "AS" }

      it { is_expected.to eq "Ace" }
    end
  end

  describe "#value" do
    subject(:value) { card.value }

    it { is_expected.to eq 2 }

    context "when the card is a 4" do
      let(:identifier) { "4D" }

      it { is_expected.to eq 4 }
    end

    context "when the card is a 7" do
      let(:identifier) { "7C" }

      it { is_expected.to eq 7 }
    end

    context "when the card is a King" do
      let(:identifier) { "KC" }

      it { is_expected.to eq 10 }
    end

    context "when the card is a Ace" do
      let(:identifier) { "AS" }

      it { is_expected.to eq 10 }
    end
  end
end
