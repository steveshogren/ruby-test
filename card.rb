class Card
  attr_accessor :val, :suite, :suite_letter

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
    @suite_letter  = str[1, 1]
    case @suite_letter
      when "H"
      s = :hearts
      when "S"
      s = :spades
      when "D"
      s = :diamonds
      when "C"
      s = :clubs
    end 
    @suite = s
  end

  def ==(other)
    other.val == @val && other.suite == @suite
  end
end
