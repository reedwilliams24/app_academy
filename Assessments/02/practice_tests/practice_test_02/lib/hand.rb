class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
    Hand.new(deck.take(2))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    point_total = 0
    ace_count = 0

    @cards.each do |card|
      if card.value == :ace
        point_total += 11
        ace_count += 1
      else
        point_total += card.blackjack_value
      end
    end

    ace_count.times do
      point_total -= 10 if point_total > 21
    end

    point_total
  end

  def busted?
    points > 21
  end

  def hit(deck)
    raise "already busted" if busted?
    @cards.concat(deck.take(1))
  end

  def beats?(other_hand)
    return false if busted?
    return true if other_hand.busted?
    points > other_hand.points
  end

  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end