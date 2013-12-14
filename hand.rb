class Hand
  attr_accessor :cards
  def initialize(cards_str)
    @cards = cards_str.split.map { |c|
      Card.new(c)
    }.sort { |x,y|
      suite_order = 'SHDC'
      if x.val == y.val then
        suite_order.index(x.suite_letter) <=> suite_order.index(y.suite_letter)
      else
        y.val <=> x.val
      end
    }
  end

  def type
    grouped = @cards.group_by { |c| c.val}.select { |k,v| v.count > 1 }.values
    if grouped.count == 1 then
      if grouped[0].val 
      :twokind
    elsif grouped.count == 2 then
      :twopair
    else
      :highcard
    end
  end
end
