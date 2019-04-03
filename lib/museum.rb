class Museum
  attr_reader :name,
              :exhibits

  def initialize(name)
    @name = name
    @exhibits = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  # If patron_object interests are exhibits in the museum, then recommend the
  # exhibit. Expected return is an array.
  # museum.exhibits and patron.interests are both arrays.
  def recommend_exhibits(patron)
    recommended = []
    @exhibits.each do |exhibit|
      recommended << exhibit if patron.interests.include?(exhibit.name)
    end
    recommended
  end

end
