class Card
  attr_accessor :val, :suit, :suit_letter

  def initialize(str)
    @val = str[0, 1].to_i
    if @val == 0 then
      case str[0,1]
      when "A"
        @val = 14
      when "K"
        @val = 13
      when "Q"
        @val = 12  
      when "J"
        @val = 11
      end 
    end
    @suit_letter  = str[1, 1]
    case @suit_letter
      when "H"
      s = :hearts
      when "S"
      s = :spades
      when "D"
      s = :diamonds
      when "C"
      s = :clubs
    end 
    @suit = s
  end

  def ==(other)
    other.val == @val && other.suit == @suit
  end
end
