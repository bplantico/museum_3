require 'minitest/autorun'
require 'minitest/emoji'
require './lib/patron'
require './lib/exhibit'

class PatronTest < Minitest::Test

  def setup

  end

end
# pry(main)> bob = Patron.new("Bob", 20)
# # => #<Patron:0x00007fcb13b5c7d8...>
#
# pry(main)> bob.name
# # => "Bob"
#
# pry(main)> bob.spending_money
# # => 20
#
# pry(main)> bob.interests
# # => []
#
# pry(main)> bob.add_interest("Dead Sea Scrolls")
#
# pry(main)> bob.add_interest("Gems and Minerals")
#
# pry(main)> bob.interests
# # => ["Dead Sea Scrolls", "Gems and Minerals"]
