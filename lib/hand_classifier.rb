require "pry"

class HandClassifier
  def initialize(hand)
    @hand = hand
  end

  def classify
    card_counts = @hand.cards.each_with_object(Hash.new(0)) do |card, counts|
      counts[card.rank] += 1
    end

    return "Straight Flush" if differences(@hand.sorted_card_values).uniq.count == 1 && @hand.card_suits.uniq.count == 1
    return "Four of a Kind" if duplicated_values(4, card_counts).any?
    if full_house?(card_counts)
      return "Full House"
    end
    return "Flush" if @hand.card_suits.uniq.count == 1
    return "Straight" if differences(@hand.sorted_card_values).uniq.count == 1
    return "Three of a Kind" if three_of_a_kind?(card_counts)
    return "Two Pairs" if duplicated_values(2, card_counts).count == 2
    return "Pair" if duplicated_values(2, card_counts).count == 1
    return "High Card" if card_counts.count == 5
  end

  private

  def duplicated_values(times_duplicated, card_counts)
    card_counts.values.filter_map do |value|
      value == times_duplicated
    end
  end

  def differences(arr)
    arr.each_cons(2).map { |a, b| b - a }
  end

  def full_house?(card_counts)
    pair = duplicated_values(2, card_counts).any?

    pair && three_of_a_kind?(card_counts)
  end

  def three_of_a_kind?(card_counts)
    duplicated_values(3, card_counts).any?
  end
end
