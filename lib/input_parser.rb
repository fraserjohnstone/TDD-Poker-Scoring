class InputParser
  def initialize(input)
    @input = input
  end

  def parse
    {
      black: black_cards,
      white: white_cards
    }
  end

  private

  def black_cards
    card_identifiers.first(5)
  end

  def white_cards
    card_identifiers.last(5)
  end

  def card_identifiers
    @card_identifiers ||= @input.gsub('Black:', '').gsub('White:', '').split(' ').map(&:strip)
  end
end
