require_relative "hand"
require_relative "card"
require "test/unit"

class TestHankRanker < Test::Unit::TestCase
  def testHandsEquality
    assert_equal(card("3H"), card("3H"))
    assert_equal(card("2D"), card("2D"))
  end

  def card(s)
    Card.new(s)
  end

  def test_Card_new
    h3 = card("3H")
    assert_equal(3, h3.val)
    assert_equal(:hearts, h3.suite)

    sk = card("KS")
    assert_equal(13, sk.val)
    assert_equal(:spades, sk.suite)

    cq = card("QC")
    assert_equal(12, cq.val)
    assert_equal(:clubs, cq.suite)

    dj = card("JD")
    assert_equal(11, dj.val)
    assert_equal(:diamonds, dj.suite)

    da = card("AD")
    assert_equal(14, da.val)
    assert_equal(:diamonds, da.suite)
  end

  def test_Hand_init_also_sorts
    h = Hand.new("3C KS KD KC KH")
    assert_equal(card("KS"), h.cards[0])
    assert_equal(card("KH"), h.cards[1])
    assert_equal(card("KD"), h.cards[2])
    assert_equal(card("KC"), h.cards[3])
    assert_equal(card("3C"), h.cards[4])
  end

  def setup
    @highc = Hand.new("2D 3C KS 4D 9H")
    @twokind = Hand.new("2D 2C KS 4D 9H")
    @twopair = Hand.new("2D 2C KS KD 9H")
    @threekind = Hand.new("2D 2C 2S KD 9H")
    @straight = Hand.new("6D 3C 4S 5D 2H")
    @straight_a_low = Hand.new("2D 3C 4S 5D AH")
  end

  def test_Hand_type
    setup()
    assert_equal(:highcard, @highc.type)
    assert_equal(:twokind, @twokind.type)
    assert_equal(:twopair, @twopair.type)
    assert_equal(:threekind, @threekind.type)
    assert_equal(:straight, @straight.type)
    assert_equal(:straight, @straight_a_low.type)

    # doesn't accept 10 as valid input
    # h = Hand.new("10D JC QS KD AH")
    # assert_equal(:straight, h.type)
  end

  def test_HankRanker
    setup()
    rankedHands = Hand.rank([@twopair, @highc, @straight_a_low, @threekind, @twokind, @straight])
    assert_equal(@straight_a_low, rankedHands[0])
    assert_equal(@straight, rankedHands[1])
    assert_equal(@threekind, rankedHands[2])
    assert_equal(@twopair, rankedHands[3])
    assert_equal(@twokind, rankedHands[4])
    assert_equal(@highc, rankedHands[5])
  end
 
end
