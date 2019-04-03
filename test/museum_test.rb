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

end
# pry(main)> bob = Patron.new("Bob", 20)
# # => #<Patron:0x00007fb400a51cc8...>
#
# pry(main)> bob.add_interest("Dead Sea Scrolls")
#
# pry(main)> bob.add_interest("Gems and Minerals")
#
# pry(main)> sally = Patron.new("Sally", 20)
# # => #<Patron:0x00007fb400036338...>
#
# pry(main)> sally.add_interest("IMAX")
#
# pry(main)> dmns.recommend_exhibits(bob)
# # => [#<Exhibit:0x00007fb400bbcdd8...>, #<Exhibit:0x00007fb400b851f8...>]
#
# pry(main)> dmns.recommend_exhibits(sally)
# # => [#<Exhibit:0x00007fb400acc590...>]
#
