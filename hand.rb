class Hand
  attr_accessor :cards

  def self.cardSort(x, y)
    suit_order = 'SHDC'
    if x.val == y.val then
      suit_order.index(x.suit_letter) <=> suit_order.index(y.suit_letter)
    else
      y.val <=> x.val
    end
  end

  def initialize(cards_str)
    @cards = cards_str.split.map { |c|
      Card.new(c)
    }.sort { |x,y| Hand.cardSort(x, y)}
  end

  def isStraight?
    @cards[0].val-4 == @cards[4].val ||
      (@cards[0].val == 14 && @cards[1].val-3 == @cards[4].val)
  end

  def type
    grouped = @cards.group_by { |c| c.val}.select { |k,v| v.count > 1 }.values
    if grouped.count == 1 then
      if grouped[0].count == 2 then
        :twokind
      elsif grouped[0].count == 3 then
        :threekind
      end
    elsif grouped.count == 2 then
      :twopair
    elsif isStraight? then
      :straight
    else
      :highcard
    end
  end
  
  def self.rank(hands)
    hand_ranks = [:highcard, :twokind, :twopair, :threekind, :straight, :flush, :fullhouse, :fourkind, :straightflush]
    hands.sort{ |x,y|
      # both are same type
      if x.type == y.type then
        Hand.cardSort(x.cards[0], y.cards[0])
      else
        hand_ranks.index(y.type) <=> hand_ranks.index(x.type)
      end
    }
  end
end
