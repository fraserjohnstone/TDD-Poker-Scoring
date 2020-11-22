require_relative "input_parser"
require_relative "card"
require_relative "hand"

class Game
  def initialize(input)
    parsed_input = InputParser.new(input).parse

    black_cards = parsed_input[:black].map do |identifier|
      Card.new(identifier)
    end
    white_cards = parsed_input[:white].map do |identifier|
      Card.new(identifier)
    end

    @black_hand = Hand.new(black_cards)
    @white_hand = Hand.new(white_cards)

    return "White wins"
  end

  def result
    if @black_hand.classification == @white_hand.classification
      return "Tie" if @black_hand.high_card_info.last == @white_hand.high_card_info.last
      return "Black wins - High card: #{@black_hand.high_card_info.first}" if @black_hand.high_card_info.last > @white_hand.high_card_info.last
      return "White wins - High card: #{@white_hand.high_card_info.first}" if @white_hand.high_card_info.last > @black_hand.high_card_info.last

      binding.pry
    elsif @black_hand.classification_points > @white_hand.classification_points
      "Black wins - #{@black_hand.classification}"
    else
      "White wins - #{@white_hand.classification}"
    end
  end
end
