require 'minitest/autorun'
require 'minitest/emoji'
require './lib/patron'
require './lib/exhibit'
require './lib/museum'

class MuseumTest < Minitest::Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)
    @bob = Patron.new("Bob", 20)
    @sally = Patron.new("Sally", 20)
    @tj = Patron.new("TJ", 7)


  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_exhibits_initializes_empty
    assert_equal [], @dmns.exhibits
  end

  def test_add_exhibit_method
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    expected = [@gems_and_minerals, @dead_sea_scrolls, @imax]

    assert_equal expected, @dmns.exhibits
  end

  def test_recommend_exhibits_method
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")

    @sally.add_interest("IMAX")

    expected_bob = [@gems_and_minerals, @dead_sea_scrolls]
    expected_sally = [@imax]

    assert_equal expected_bob, @dmns.recommend_exhibits(@bob)
    assert_equal expected_sally, @dmns.recommend_exhibits(@sally)
  end

   # passes a patron object in as argument. Adds the patron to patrons array.
   # Also adds the patron as a value in a hash and the hash key is
   # the exhibit
  def test_admit_method
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("Dead Sea Scrolls")

    @dmns.admit(@bob)
    @dmns.admit(@sally)

    assert_equal [@bob, @sally], @dmns.patrons
  end

  def test_patrons_by_exhibit_method
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("Dead Sea Scrolls")

    @dmns.admit(@bob)
    @dmns.admit(@sally)

    # return is a hash with Exhibit objects as keys and arrays of Patron
    # objects as values
    expected_1 = {
                @gems_and_minerals => [@bob],
                @dead_sea_scrolls  => [@bob, @sally],
                @imax              => []
                }

    assert_equal expected_1, @dmns.patrons_by_exhibit_interest

    @sally.add_interest("IMAX")

    expected_2 = {
                @gems_and_minerals => [@bob],
                @dead_sea_scrolls  => [@bob, @sally],
                @imax              => [@sally]
                }

    assert_equal expected_2, @dmns.patrons_by_exhibit_interest
  end

  def test_patron_spending_money_decreases_when_patron_visits_exhibit
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @tj.add_interest("IMAX")
    @tj.add_interest("Dead Sea Scrolls")

    @dmns.admit(@tj)

    assert_equal 7, @tj.spending_money

    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("IMAX")

    @dmns.admit(@bob)

    assert_equal 0, @bob.spending_money
  end

end

# # This Patron is interested in two exhibits and only Dead Sea Scrolls
# # is in their price range price, so they attend Dead Sea Scrolls
# pry(main)> bob = Patron.new("Bob", 10)
# # => #<Patron:0x00007f9018048be8...>

# pry(main)> dmns.admit(bob)
#
# pry(main)> bob.spending_money
# # => 0
#
# # This Patron is interested in two exhibits and both are in their price range.
# # They attend the more expensive one first (IMAX), but don't have enough money to attend
# # the second one
# pry(main)> sally = Patron.new("Sally", 20)
# # => #<Patron:0x00007f901823c8a0...>
#
# pry(main)> sally.add_interest("Dead Sea Scrolls")
#
# pry(main)> sally.add_interest("IMAX")
#
# pry(main)> dmns.admit(sally)
#
# pry(main)> sally.spending_money
# # => 5
#
# # This Patron is interested in two exhibits and both are in their price range.
# # They have enough spending money to afford both, so they attend both.
# pry(main)> morgan = Patron.new("Morgan", 15)
# # => #<Patron:0x00007f90180e0948...>
#
# pry(main)> morgan.add_interest("Gems and Minerals")
#
# pry(main)> morgan.add_interest("Dead Sea Scrolls")
#
# pry(main)> dmns.admit(morgan)
#
# pry(main)> morgan.spending_money
# # => 5
#
# pry(main)> dmns.patrons_of_exhibits
# # =>
# # {
# #   #<Exhibit:0x00007f9019879be0...> => [#<Patron:0x00007f9018048be8...>, <Patron:0x00007f90180e0948...>],
# #   #<Exhibit:0x00007f9018a596c8...> => [#<Patron:0x00007f901823c8a0...>],
# #   #<Exhibit:0x00007f9018a51248...> => [#<Patron:0x00007f90180e0948...>]
# # }
#
# pry(main)> dmns.revenue
# # => 35
