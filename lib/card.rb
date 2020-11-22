require 'pry'

class Card
  def initialize(identifier)
    @identifier = identifier
  end

  def suit
    {
      "H" => "Hearts",
      "D" => "Diamonds",
      "S" => "Spades",
      "C" => "Clubs"
    }[@identifier[-1]]
  end

  def rank
    case @identifier[0]
    when /\d/
      @identifier[0]
    when /\D/
      {
        "J" => "Jack",
        "Q" => "Queen",
        "K" => "King",
        "A" => "Ace"
      }[@identifier[0]]
    end
  end

  def value
    case @identifier[0]
    when /\d/
      @identifier[0].to_i
    when /\D/
      10
    end
  end
end
