require_relative '../lib/input_parser'

describe InputParser do
  let(:parser) { described_class.new(input) }
  let(:input) { "Black: 2H 3D 5S 9C KD White: 2C 3H 4S 8C AH" }

  describe "#parse" do
    subject(:parse) { parser.parse }

    let(:expected_output) {
      {
          black: %w[2H 3D 5S 9C KD],
          white: %w[2C 3H 4S 8C AH]
      }
    }

    it { is_expected.to be_a Hash }
    it { is_expected.to have_key(:black) }
    it { is_expected.to have_key(:white) }

    it "the black and white keys will be associated with arrays as values" do
      expect(parse[:black]).to be_an Array
      expect(parse[:white]).to be_an Array
    end

    it "will return strings in the arrays" do
      expect(parse[:black].first).to be_a String
      expect(parse[:white].first).to be_a String
    end

    it "will return the expected output" do
      expect(parse).to eq expected_output
    end
  end
end
