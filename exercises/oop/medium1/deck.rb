class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end
  
  def reset
    @deck = []
    
    SUITS.each do |suit|
      RANKS.each do |rank|
        @deck << Card.new(rank, suit)
      end
    end
    
    @deck.shuffle!
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end
end

class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def value
    VALUES.fetch(@rank, @rank)
  end
  
  def <=>(other)
    value <=> other.value
  end
  
  def to_s
    "#{@rank} of #{@suit}"
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
drawn.count { |card| card.rank == 5 } == 4
drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
drawn != drawn2 # Almost always.