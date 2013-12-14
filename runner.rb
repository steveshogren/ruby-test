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
  end

  def test_Hand_init_also_sorts
    h = Hand.new("3C KS KD KC KH")
    assert_equal(card("KS"), h.cards[0])
    assert_equal(card("KH"), h.cards[1])
    assert_equal(card("KD"), h.cards[2])
    assert_equal(card("KC"), h.cards[3])
    assert_equal(card("3C"), h.cards[4])
  end

  def test_Hand_type
    h = Hand.new("2D 3C KS 4D 9H")
    assert_equal(:highcard, h.type)
    assert_equal(card("KS"), h.cards[0])

    h = Hand.new("2D 2C KS 4D 9H")
    assert_equal(:twokind, h.type)

    h = Hand.new("2D 2C KS KD 9H")
    assert_equal(:twopair, h.type)

    h = Hand.new("2D 2C 2S KD 9H")
    assert_equal(:threekind, h.type)
  end
 
end
