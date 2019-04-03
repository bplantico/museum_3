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

    expected_bob = [@dead_sea_scrolls, @gems_and_minerals]
    expected_sally = [@dead_sea_scrolls, @gems_and_minerals]

    assert_equal expected_bob, @dmns.recommend_exhibits(@bob)
    assert_equal expected_sally, @dmns.recommend_exhibits(@sally)
  end

end

# pry(main)> dmns.recommend_exhibits(bob)
# # => [#<Exhibit:0x00007fb400bbcdd8...>, #<Exhibit:0x00007fb400b851f8...>]
#
# pry(main)> dmns.recommend_exhibits(sally)
# # => [#<Exhibit:0x00007fb400acc590...>]
#
