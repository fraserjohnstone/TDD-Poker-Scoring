require_relative "hand_classifier"

class Hand
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def classification
    @classification ||= HandClassifier.new((self)).classify
  end

  def card_values
    @cards.map(&:value)
  end

  def card_ranks
    @cards.map(&:rank)
  end

  def sorted_card_values
    card_values.sort
  end

  def card_suits
    @cards.map(&:suit)
  end

  def classification_points
    {
      "Straight Flush" => 9,
      "Four of a Kind" => 8,
      "Full House" => 7,
      "Flush" => 6,
      "Straight" => 5,
      "Three of a Kind" => 4,
      "Two Pairs" => 3,
      "Pair" => 2,
      "High Card" => 1
    }[classification]
  end

  def high_card_info
    return ["Ace", 13] if card_ranks.any?("Ace")
    return ["King", 12] if card_ranks.any?("King")
    return ["Queen", 11] if card_ranks.any?("Queen")
    return ["Jack", 10] if card_ranks.any?("Jack")
    return ["9", 9] if card_ranks.any?("9")
    return ["8", 8] if card_ranks.any?("8")
    return ["7", 7] if card_ranks.any?("7")
    return ["6", 6] if card_ranks.any?("6")
    return ["5", 5] if card_ranks.any?("5")
    return ["4", 4] if card_ranks.any?("4")
    return ["3", 3] if card_ranks.any?("3")
    return ["2", 2] if card_ranks.any?("2")

  end
end
