require 'minitest/autorun'
require 'minitest/emoji'
require './lib/patron'
require './lib/exhibit'

class PatronTest < Minitest::Test

  def setup
    @bob = Patron.new("Bob", 20)
  end

  def test_it_exists
    assert_instance_of Patron, @bob
  end

  def test_it_has_attributes
    assert_equal "Bob", @bob.name
    assert_equal 20, @bob.spending_money
  end

  def test_interests_initializes_empty
    assert_equal [], @bob.interests
  end

  def test_add_interest_method
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")

    assert_equal ["Dead Sea Scrolls", "Gems and Minerals"], @bob.interests
  end

end
